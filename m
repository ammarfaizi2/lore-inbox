Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265293AbUETWsN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265293AbUETWsN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 May 2004 18:48:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265253AbUETWsN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 May 2004 18:48:13 -0400
Received: from MAIL.13thfloor.at ([212.16.62.51]:58843 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S265238AbUETWsK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 May 2004 18:48:10 -0400
Date: Fri, 21 May 2004 00:48:09 +0200
From: Herbert Poetzl <herbert@13thfloor.at>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: file attributes (ext2/3) in 2.4.26
Message-ID: <20040520224809.GA31445@MAIL.13thfloor.at>
Mail-Followup-To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
	linux-kernel@vger.kernel.org
References: <20040517185141.GA23102@MAIL.13thfloor.at> <20040520215909.GB21344@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040520215909.GB21344@logos.cnet>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 20, 2004 at 06:59:09PM -0300, Marcelo Tosatti wrote:
> On Mon, May 17, 2004 at 08:51:41PM +0200, Herbert Poetzl wrote:
> > 
> > Hi Folks!
> > 
> > is it intentional that the file attributes
> > (those accessible with chattr -*) are modifyable
> > even if a file has the 'i' immutable flag set,
> > and the user is lacking CAP_IMMUTABLE (or all
> > CAPs if you prefer that ;)
> > 
> > # touch /tmp/x
> > # chattr +iaA /tmp/x
> > 
> > # lcap -z
> > # chattr -i /tmp/x 
> > chattr: Operation not permitted while setting flags on /tmp/x
> > 
> > # chattr -A /tmp/x 
> > # lsattr /tmp/x
> > ----ia------- /tmp/x
> > 
> > I'd consider this a bug, but it might be some
> > strange posix/linux conformance issue too ...
> > 
> > let me know if this _is_ a bug, if so, I'm 
> > willing to provide patches to fix it ...
> 
> Hi Herbert,
> 
> The chattr man page says
> 
>   A file with the `i' attribute cannot be modified: it cannot be  deleted
>   or  renamed,  no  link  can  be created to this file and no data can be
>   written to the file.  Only the superuser or a  process  possessing  the
>   CAP_LINUX_IMMUTABLE capability can set or clear this attribute.
> 
> You still can modify other flags from the file, right?

yep, that is what I consider unexpected behavior, but the 
man page doesn't say anything about other flags ... 

in the example above (which should be easy to verify) the 
'A' (noatime) flag is cleared while 'i' is set and the 
user (root) has no capability at all ...

the same is true for all other attribute flags for
ext2/ext3, reiserfs and probably other fs implementing
those attributes.

best,
Herbert

