Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314559AbSE0ItK>; Mon, 27 May 2002 04:49:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314643AbSE0ItJ>; Mon, 27 May 2002 04:49:09 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:14330 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S314559AbSE0ItI>; Mon, 27 May 2002 04:49:08 -0400
Subject: Re: PROBLEM: memory corruption with i815 chipset variant
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Nicolas Aspert <Nicolas.Aspert@epfl.ch>
Cc: Alessandro Morelli <alex@alphac.it>, linux-kernel@vger.kernel.org
In-Reply-To: <3CF1EA3F.4070608@epfl.ch>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 27 May 2002 10:51:26 +0100
Message-Id: <1022493086.11859.191.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-05-27 at 09:11, Nicolas Aspert wrote:
> Alessandro reported the problem to me also. I went through the i815 
> specs and found 2 'strange' things (maybe they are not but...)
> 1) No 'ERRSTS' register (well... a bus that does no error should be a 
> feature ;-)
> 2) The ATTBASE register to which the *_configure functions write is 
> different from other Intel chipsets. In the i815, the ATT base adress 
> should be written between bits 12 and 28, whereas in all other Intel 
> chipsets, it should be written between bits 12 and 31 (don't ask me why 
> Intel feels like changing the adresses/specs for registers at each new 
> chipsets....) .
> Alan, do you think this could cause all those troubles ?

It certainly could be. If bits 29-31 maybe control things like memory
timings then it could do quite horrible things. Fixing it to leave the
ERRSTS register alone and keep bits 29-31 is definitely worth trying. If
that fixes it then its going to be easy enough to drop a fix into the
mainstream code

Alan

