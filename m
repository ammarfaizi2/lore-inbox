Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751544AbWCLRnD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751544AbWCLRnD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Mar 2006 12:43:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751618AbWCLRnB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Mar 2006 12:43:01 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:52242 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1751544AbWCLRnB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Mar 2006 12:43:01 -0500
Date: Sun, 12 Mar 2006 18:42:50 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Petr Vandrovec <petr@vandrovec.name>
Cc: linux-kernel@vger.kernel.org, sam@ravenborg.org, kai@germaschewski.name
Subject: Re: [PATCH] Do not rebuild full kernel tree again and again...
Message-ID: <20060312174250.GA1470@mars.ravnborg.org>
References: <20060312172511.GA17936@vana.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060312172511.GA17936@vana.vc.cvut.cz>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 12, 2006 at 06:25:11PM +0100, Petr Vandrovec wrote:
> Hello,
>   I've returned back to the computer after month and half, and I've found that
> I cannot reasonably build kernel - just repeating 'make' twice without doing any
> change forced full rebuild of everything, which as far as I can tell is not 
> intended behavior.  As I did not notice this being reported on the LKML, and
> 2.6.16-rc6 still suffers from this problem, here comes report + patch.
> 
>   Problem seems to be that new make includes FORCE prerequisite in $? - apparently
> new make treats $? not as 'prerequisities newer than target', but as 
> 'prerequisities newer than target or missing'.  Due to this $(if) in make rules 
> always succeeded as it always received at least 'FORCE', and 'FORCE'
> is not an empty string.  So let's filter out 'FORCE' from $? - unless somebody
> can confirm that make 3.81 is broken and unusable for kernel...

This issue has been discussed with Paul D. Smith which also provided
a patch similar to yours.
The patch is in the kbuild queue for 2.6.17.
But we also agreed to postpose this change in make until next stable
release. So if you update your make to latest CVS version you will no
longer see this misbehaviour.
And when 2.6.17 opens up kbuild will be 'fixed' in mainline kernel.

	Sam
