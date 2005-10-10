Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751178AbVJJSmt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751178AbVJJSmt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Oct 2005 14:42:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751177AbVJJSms
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Oct 2005 14:42:48 -0400
Received: from wproxy.gmail.com ([64.233.184.207]:16573 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751173AbVJJSmr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Oct 2005 14:42:47 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:disposition-notification-to:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=AAd6rAI0o2rHKicPV81fSlbabceRUVIjk4UI4sSbdVAqEtjKwESEN24drIRkFLaOXe/bRSre+5G4TorszDU8amMdeZLlTwWZ899JfRZ9YBZFQGBYLBCKkJjxSmwFem9Tgk7CZMVf7cyIW2Pc58D5C3pXJsMSKwyxtd9bx0nYZgY=
Message-ID: <434AB1EB.6070309@gmail.com>
Date: Mon, 10 Oct 2005 20:24:43 +0200
From: Alon Bar-Lev <alon.barlev@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20051008)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
CC: "H. Peter Anvin" <hpa@zytor.com>, Jesper Juhl <jesper.juhl@gmail.com>
Subject: Re: [PATCH 1/1] 2.6.14-rc3 x86: COMMAND_LINE_SIZE
References: <431628D5.1040709@zytor.com> <431DF9E9.5050102@gmail.com> <431DFEC3.1070309@zytor.com> <431E00C8.3060606@gmail.com> <4345A9F4.7040000@uni-bremen.de> <434A6220.3000608@gmx.de> <9a8748490510100621x7bc20c42g667cc083d26aaaa2@mail.gmail.com> <434A8082.9060202@zytor.com> <434A8CE8.2020404@gmx.de> <434A8D70.5060300@zytor.com> <20051010171605.GA7793@georg.homeunix.org>
In-Reply-To: <20051010171605.GA7793@georg.homeunix.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Georg Lippold wrote:
> H. Peter Anvin wrote on Mon, Oct 10, 2005 at 08:49:04AM -0700:
> 
>>I would suggest updating your patch to include x86-64 and documentation, 

Hi!

Just a few suggestions...

1. The old protocol must stay with 255 + null command 
line... I suggest:

For boot protocol <2.02, the kernel command line is a 
null-terminated string up to 255 characters long, plus the 
final null. For boot protocol >=2.02 command line that is 
referred by cmd_line_ptr is null-terminated string, the 
kernel will truncate this string if it is too large to handle.

2. I suggest adding a new configuration to set the size of 
command-line, so it won't be hard coded...

Add CONFIG_CMD_LINE_SIZE with default of 1024.

I've done this by init/Kconfig...

--- Kconfig     2005-10-10 20:16:14.000000000 +0200
+++ Kconfig.org 2005-10-10 20:14:13.000000000 +0200
@@ -77,13 +77,6 @@ config LOCALVERSION
           object and source tree, in that order.  Your 
total string can
           be a maximum of 64 characters.

+config CMD_LINE_SIZE
+       integer "Set maximum command line size"
+       default 1024
+       help
+         This option allows you to specify the maximum 
kernel command
+         line arguments.
+
  config SWAP
         bool "Support for paging of anonymous memory (swap)"
         depends on MMU

3. Set the COMMAND_LINE_SIZE to CONFIG_CMD_LINE_SIZE

I've found that not all files that includes setup.h and 
param.h include config.h... So I've written:

#if defined(CONFIG_CMD_LINE_SIZE)
#define COMMAND_LINE_SIZE CONFIG_CMD_LINE_SIZE
#endif

So that it fails if you try to use COMMAND_LINE_SIZE and did 
not include config.h, another alternative is to include 
config.h in these include files... I don't know what the 
conventions are.

Best Regards,
Alon Bar-Lev.
