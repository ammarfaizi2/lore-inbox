Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315198AbSHMMLu>; Tue, 13 Aug 2002 08:11:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315200AbSHMMLu>; Tue, 13 Aug 2002 08:11:50 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:2296 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S315198AbSHMMLu>; Tue, 13 Aug 2002 08:11:50 -0400
Subject: Re: [PATCH]2.4.20 ARCH=i386 create dmi_scan.h and move decl from
	dmi_scan.c
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Albert Cranford <ac9410@attbi.com>,
       Linus Torvalds <torvalds@transmeta.com>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <3D589E11.6093B119@attbi.com>
References: <3D589E11.6093B119@attbi.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 13 Aug 2002 13:13:04 +0100
Message-Id: <1029240784.21007.19.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-08-13 at 06:50, Albert Cranford wrote:
> -
> -static char *dmi_ident[DMI_STRING_MAX];
> +char *dmi_ident[DMI_STRING_MAX];

Be very careful with this change btw. The dmi_ident strings are unmapped
at the point dmi_table() returns. That means you can only use them in
the decode callback, and so it seems odd to export them. It certainly
wants clear documentation if you are doing it that way. 

What you probably should do is create some flag bits for i2c/smbus and
set those then export the flag data (we do the same for APM), rather
than export them as globals

