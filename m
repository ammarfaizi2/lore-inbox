Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261645AbSIXMg3>; Tue, 24 Sep 2002 08:36:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261656AbSIXMg3>; Tue, 24 Sep 2002 08:36:29 -0400
Received: from [217.167.51.129] ([217.167.51.129]:26850 "EHLO zion.wanadoo.fr")
	by vger.kernel.org with ESMTP id <S261645AbSIXMg3>;
	Tue, 24 Sep 2002 08:36:29 -0400
From: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>
To: "Richard Zidlicky" <rz@linux-m68k.org>,
       "Andre Hedrick" <andre@linux-ide.org>
Cc: "Alan Cox" <alan@lxorguk.ukuu.org.uk>, <linux-kernel@vger.kernel.org>
Subject: Re: IDE janitoring comments
Date: Tue, 24 Sep 2002 14:41:33 +0200
Message-Id: <20020924124133.29552@192.168.4.1>
In-Reply-To: <20020924113535.11318@192.168.4.1>
References: <20020924113535.11318@192.168.4.1>
X-Mailer: CTM PowerMail 4.0.1 carbon <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>I need different transfer functions depending on whether drive
>>control data(like IDENT,SMART) or HD sectors are to be transfered. 
>>Control data requires byteswapping to correct bus-byteorder
>>whereas sector r/w has to be raw for compatibility.
>>
>>So that will require 2 additional iops pointers and some change
>>in ide_handler_parser or ide_cmd_type_parser to select the
>>appropriate version depending on the drive command.
>
>No, it doesn't. There are already separate iops for control
>and datas, typically {in,out}{b,w,l} are for control (though
>only "b" versions are really useful and {in,out}s{b,w,l} are
>for datas.

Oops, sorry, I mis-read you

Well, if you have proper iops that swap for normal datas, then
you can use the "normal" fixup routines for control datas
like ident, the same we use on PPC or other BE archs.

The problem is typiucally the same for everybody here: the
swapping of datas themselves must be done so that you get an
exact image of the datas in memory, then you need additional
fixup to "interpret" some of these (ident, smart, ...)

Ben.


