Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751201AbWHQGlf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751201AbWHQGlf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 02:41:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750959AbWHQGlf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 02:41:35 -0400
Received: from wx-out-0506.google.com ([66.249.82.233]:43347 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1750824AbWHQGle (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 02:41:34 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=SFZQrFUZ5vHnv3HH8kXH7Zt9/IOto8Om42/am1pDOSjHlnMwHEDtzuzdVSFoFQ7iKa01YX9YoeQeyvq5jaZPmJJw1EfRY59cgvmeGzICQnKui93lEnXfy+g2rlxwlmYXhIDc8zakUPCyjLEtFPXnb7rSZzJK5P78/Ua+yMOxSUU=
From: Patrick McFarland <diablod3@gmail.com>
To: "Anonymous User" <anonymouslinuxuser@gmail.com>
Subject: Re: GPL Violation?
Date: Thu, 17 Aug 2006 02:42:40 -0400
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org
References: <40d80630608162248y498cb970r97a14c582fd663e1@mail.gmail.com>
In-Reply-To: <40d80630608162248y498cb970r97a14c582fd663e1@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608170242.40969.diablod3@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 17 August 2006 01:48, Anonymous User wrote:
> I work for a company that will be developing an embedded Linux based
> consumer electronic device.
>
> I believe that new kernel modules will be written to support I/O
> peripherals and perhaps other things.  I don't know the details right
> now.  What I am trying to do is get an idea of what requirements there
> are to make the source code available under the GPL.

I am not a lawyer, and I suggest your company speak with one before doing 
this. (And most likely, someone from the list will correct me if I get 
something wrong).

However, your company only has to release any code they use, preferably in the 
form of unmodified tarballs (pointing to project websites for downloads isn't 
valid anymore) plus patches against said unmodified tarballs if modified. If 
not modified, you still have to release the unmodified tarballs.

They don't have to release source code for any module you wrote from scratch 
themselves, but said modules cannot say they are GPL (ie, they have to poison 
the kernel).

Also, said kernel modules have to be real modules and not statically linked 
into the kernel, and said modules have to have the compiled component objects 
(ie, *.o) available so people can relink them into new modules to work with 
new kernels.

In addition, you probably want to distribute the original source for any file 
that uses a kernel API directly so people can fix things if/when the API 
changes (which implies using dummy functions that access the kernel API and 
call symbols in the closed source objects that do the actual work and form 
the bulk of the code).

An example of what to do is what ATI and Nvidia did for their hardware access 
modules. An example of what *not* to do is what Broadcom does for their wifi 
AP drivers (which are broken on 2.6.x due to API change) and what Linuxant 
does for their modem drivers (which are broken on nearly all kernels no 
matter the version).

*However*, it would totally rock if your company did GPL any new modules and 
send it to Linus; they'd get free patches/code from the community and lots of 
karma as well. Having a built-in customer base is never bad...

Also, completely open sourcing the drivers means, if applicable, people can 
use the hardware on platforms other than your processor architecture of 
choice. ie, lots of people are screwed because of x86 only modules and they 
want to run on PPC or Alpha or whatever.

-- 
Patrick McFarland || www.AdTerrasPerAspera.com
"Computer games don't affect kids; I mean if Pac-Man affected us as kids,
we'd all be running around in darkened rooms, munching magic pills and
listening to repetitive electronic music." -- Kristian Wilson, Nintendo,
Inc, 1989

