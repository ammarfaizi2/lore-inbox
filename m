Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289815AbSBKPJU>; Mon, 11 Feb 2002 10:09:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289817AbSBKPJK>; Mon, 11 Feb 2002 10:09:10 -0500
Received: from host194.steeleye.com ([216.33.1.194]:41746 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S289815AbSBKPIx>; Mon, 11 Feb 2002 10:08:53 -0500
Message-Id: <200202111508.g1BF8fu01678@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: pazke@orbita1.ru (Andrey Panin),
        James.Bottomley@HansenPartnership.com (James Bottomley),
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH: NEW ARCHITECTURE FOR 2.5.3] support for NCR voyager 
In-Reply-To: Message from Alan Cox <alan@lxorguk.ukuu.org.uk> 
   of "Mon, 11 Feb 2002 13:41:11 GMT." <E16aGhj-0006cu-00@the-village.bc.nu> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 11 Feb 2002 10:08:41 -0500
From: James Bottomley <James.Bottomley@HansenPartnership.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It's historical creep.

Initially the question about being Voyager was asked immediately below 
CONFIG_MCA, which was then at the top level.  Then that got wrapped by if != 
VISW, so it ends up looking like this.

How about:

if [ "$CONFIG_VISWS" != "y" ]; then
    bool 'MCA support' CONFIG_MCA
else
    define_bool CONFIG_MCA n
fi

if [ "$CONFIG_MCA" = "y" ]; then
    bool '   Support for the NCR Voyager Architecture' CONFIG_VOYAGER
    define_bool CONFIG_X86_TSC n
fi

Actually, this also exposes a bug, the last statement should be:

if [ "$CONFIG_MCA" = "y" ]; then
    bool '   Support for the NCR Voyager Architecture' CONFIG_VOYAGER
    if [ "$CONFIG_VOYAGER" = "y"]; then
        define_bool CONFIG_X86_TSC n
    fi
fi

Since MCA machines may use the pentium TSC but voyager may not.

James


