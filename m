Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263730AbUDTXbt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263730AbUDTXbt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Apr 2004 19:31:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263789AbUDTXas
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Apr 2004 19:30:48 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:21897 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264534AbUDTXZq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Apr 2004 19:25:46 -0400
Date: Wed, 21 Apr 2004 00:25:45 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: ken@coverity.com
Cc: linux-kernel@vger.kernel.org, linux@coverity.com
Subject: Re: [CHECKER] Security reports involving isspace()
Message-ID: <20040420232545.GF17014@parcelfarce.linux.theplanet.co.uk>
References: <12837.24.6.86.122.1082499261.spork@webmail.coverity.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <12837.24.6.86.122.1082499261.spork@webmail.coverity.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 20, 2004 at 03:14:21PM -0700, ken@coverity.com wrote:
> Here are some more static analysis reports from Coverity.  These are
> places where the kernel gets a scalar from the user and then uses it as an
> array index with out bounds checking it.
> 
> All of the reports below deal with the isspace macro.  It expands to an
> access to a static array with 256 entries.  If we use an unsigned char to
> index into the array, there are no problems.  However, when that char is
> signed, we can index off the left of the array.
> 
> It seems like this isn't a big deal, but if the isspace array is located
> after some important data structure, we could leak information.

#define __ismask(x) (_ctype[(int)(unsigned char)(x)])
#define isspace(c)      ((__ismask(c)&(_S)) != 0)

Figuring out why the reports mentioned in the quoted text are bullshit
is left as an exercise for readers.
