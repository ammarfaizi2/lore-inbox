Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261800AbREYTvi>; Fri, 25 May 2001 15:51:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261802AbREYTv3>; Fri, 25 May 2001 15:51:29 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:4802 "HELO havoc.gtf.org")
	by vger.kernel.org with SMTP id <S261800AbREYTvJ>;
	Fri, 25 May 2001 15:51:09 -0400
Message-ID: <3B0EB7A6.E0B17C79@mandrakesoft.com>
Date: Fri, 25 May 2001 15:51:02 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.5-pre6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Nemosoft Unv." <nemosoft@smcc.demon.nl>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, johannes@erdfelt.com,
        linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>, randy.dunlap@intel.com
Subject: Re: ac15 and 2.4.5-pre6, pwc format conversion
In-Reply-To: <XFMail.010525213709.nemosoft@smcc.demon.nl>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Nemosoft Unv." wrote:
> On 25-May-01 Alan Cox wrote:
> > It breaks apps by doing conversions, and it breaks important apps like H263
> > codecs not silly little camera viewers, because you trash the performance
> 
> This is a NULL argument. First, it doesn´t break anything; I think H263 is
> smart to pick a YUV format if it´s available. Second, conversion has to be
> done at one point or another. If the native format of the camera is RGB,
> H263 will have to convert to YUV. Wether or not this is done in kernel space
> or user space doesn´t matter: it has to be done. And in case the native
> format of the camera doesn´t resemble anything in V4L, you will have TWO
> conversion: first, in kernel from native to V4L palette, and then in your
> tool from V4L to whatever format you need, while maybe the driver could do
> it all in one stage.

Sorry this is a slippery slope argument and it won't wash.

The kernel is intended as the arbiter between userspace and hardware,
and userspace and userspace.  Format conversion has nothing to do with
arbitration.

Format conversion in kernelspace is far less flexible than userspace: 
you cannot replace your algorithms at will nor fix bugs at will.  You
cannot support assembly optimizations for format conversions without
bloating the kernel.

Finally, the example you describe is invalid.  If your tool is doing
-two- format conversions, then [again] the tool should be fixed.  The
kernel most definitely should not work around stupid shortcomings of
userspace software.


> Anyway, I am not going to debate this any further at this point. Johannes,
> please remove my webcam driver from the USB source tree,

whatever.  I don't see Alan or Linus accepting such a change, even if
Johannes does.


> until the software
> YUV/RGB conversion has been removed from ALL other video devices (preferably
> all at the same time).

Send a patch for this instead!

Format conversion should not be in the kernel...

	Jeff


-- 
Jeff Garzik      | "Are you the police?"
Building 1024    | "No, ma'am.  We're musicians."
MandrakeSoft     |
