Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318541AbSHPQ01>; Fri, 16 Aug 2002 12:26:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318542AbSHPQ01>; Fri, 16 Aug 2002 12:26:27 -0400
Received: from smtp-out-2.wanadoo.fr ([193.252.19.254]:27900 "EHLO
	mel-rto2.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S318541AbSHPQ00>; Fri, 16 Aug 2002 12:26:26 -0400
Message-ID: <3D5D287C.F4AE3797@wanadoo.fr>
Date: Fri, 16 Aug 2002 18:29:48 +0200
From: Jean-Luc Coulon <jean-luc.coulon@wanadoo.fr>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.20-pre2-ac3 i586)
X-Accept-Language: fr-FR, en
MIME-Version: 1.0
To: Rik van Riel <riel@conectiva.com.br>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.4.20-pre2-ac3 stops responding
References: <Pine.LNX.4.44L.0208161036170.1430-100000@imladris.surriel.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel wrote:
> 
> On Fri, 16 Aug 2002, Jean-Luc Coulon wrote:
> 
> > 2nd while running:
> > ------------------
> > If I have high disk activity, the system stops responding for a while,
> > it does not accepts any key action nor mouse movement. It starts running
> > normally after few seconds.
> 
> I've got a patch that might help improve this situation:
> 
> http://surriel.com/patches/2.4/2.4.20-p2ac3-rmap14
> 
> Could you please try this patch ?
> 
> kind regards,
> 
> Rik
> --
> Bravely reimplemented by the knights who say "NIH".
> 
> http://www.surriel.com/         http://distro.conectiva.com/

I've applied the patch, it does not improve the things.
The problem seems to be related with a DMA :
[root@debian-f5ibh] ~ # hdparm -iv /dev/hda2

/dev/hda2:
multcount    =  1 (on)
IO_support   =  1 (32-bit)
unmaskirq    =  0 (off)
using_dma    =  0 (off)
keepsettings =  0 (off)
readonly     =  0 (off)
readahead    =  8 (on)
geometry     = 3649/255/63, sectors = 29302560, start = 9767520
HDIO_GET_IDENTITY failed: Invalid argument

[root@debian-f5ibh] ~ # hdparm -d1 /dev/hda2

/dev/hda2:
setting using_dma to 1 (on)
HDIO_SET_DMA failed: Invalid argument
using_dma    =  0 (off)


----
Regards
	Jean-Luc
