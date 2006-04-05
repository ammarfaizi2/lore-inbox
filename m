Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751069AbWDEPiI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751069AbWDEPiI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Apr 2006 11:38:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751098AbWDEPiI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Apr 2006 11:38:08 -0400
Received: from zproxy.gmail.com ([64.233.162.199]:409 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751069AbWDEPiH convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Apr 2006 11:38:07 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ppW2Y4MYLpW78mQWinHyotgwZcppfRmyKhyaDqMtTqbzGhVshyE/sU5fh7rquWK8Qq+2sSkJBYLgccrFxQ//CWZx/FZgaCON1gljWQmOooYgItCZrIDX5gmdKISA9TR3HNG7tlZ4HwY1yyNeINi565wi5rDxQDolCLwujJfHjC4=
Message-ID: <9e4733910604050838g339d48cao4e0f8582f6d90187@mail.gmail.com>
Date: Wed, 5 Apr 2006 11:38:06 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Al Viro" <viro@ftp.linux.org.uk>
Subject: Re: [patch 03/26] sysfs: zero terminate sysfs write buffers (CVE-2006-1055)
Cc: gregkh@suse.de, linux-kernel@vger.kernel.org, stable@kernel.org
In-Reply-To: <20060405152123.GH27946@ftp.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060404235634.696852000@quad.kroah.org>
	 <20060404235947.GD27049@kroah.com>
	 <20060405190928.17b9ba6a.vsu@altlinux.ru>
	 <20060405152123.GH27946@ftp.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/5/06, Al Viro <viro@ftp.linux.org.uk> wrote:
> On Wed, Apr 05, 2006 at 07:09:28PM +0400, Sergey Vlasov wrote:
> > This will break the "color_map" sysfs file for framebuffers -
> > drivers/video/fbsysfs.c:store_cmap() expects to get exactly 4096 bytes
> > for a colormap with 256 entries.  In fact, the original patch which
> > changed PAGE_SIZE - 1 to PAGE_SIZE:
>
> ... cheerfully assuming that nobody assumes NUL-termination and
> everyone (sysfs patch writers!) certainly uses the length argument.
> Fscking brilliant, that.
>
> Are you willing to audit all sysfs ->show() in the kernel?  Original
> author of that turd had not been.
>
> FWIW, "color_map" is a blatant abuse of interface.  Doesn't get
> any more borderline...

The firmware interface is worse. You write the ROM image line by line
to the attribute and a hidden counter tracks how far your are into the
image.

There needs to be a standardized way to transfer larger pieces of data
via sysfs or we should go back to IOCTLs.

--
Jon Smirl
jonsmirl@gmail.com
