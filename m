Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265303AbUETV6x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265303AbUETV6x (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 May 2004 17:58:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265245AbUETV6x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 May 2004 17:58:53 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:44974 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265286AbUETV6L
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 May 2004 17:58:11 -0400
Date: Thu, 20 May 2004 18:59:09 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: linux-kernel@vger.kernel.org
Cc: Herbert Poetzl <herbert@13thfloor.at>
Subject: Re: file attributes (ext2/3) in 2.4.26
Message-ID: <20040520215909.GB21344@logos.cnet>
References: <20040517185141.GA23102@MAIL.13thfloor.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040517185141.GA23102@MAIL.13thfloor.at>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 17, 2004 at 08:51:41PM +0200, Herbert Poetzl wrote:
> 
> Hi Folks!
> 
> is it intentional that the file attributes
> (those accessible with chattr -*) are modifyable
> even if a file has the 'i' immutable flag set,
> and the user is lacking CAP_IMMUTABLE (or all
> CAPs if you prefer that ;)
> 
> # touch /tmp/x
> # chattr +iaA /tmp/x
> 
> # lcap -z
> # chattr -i /tmp/x 
> chattr: Operation not permitted while setting flags on /tmp/x
> 
> # chattr -A /tmp/x 
> # lsattr /tmp/x
> ----ia------- /tmp/x
> 
> I'd consider this a bug, but it might be some
> strange posix/linux conformance issue too ...
> 
> let me know if this _is_ a bug, if so, I'm 
> willing to provide patches to fix it ...

Hi Herbert,

The chattr man page says

       A file with the `i' attribute cannot be modified: it cannot be  deleted
       or  renamed,  no  link  can  be created to this file and no data can be
       written to the file.  Only the superuser or a  process  possessing  the
       CAP_LINUX_IMMUTABLE capability can set or clear this attribute.

You still can modify other flags from the file, right?
