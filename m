Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267217AbTA0QOu>; Mon, 27 Jan 2003 11:14:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267218AbTA0QOt>; Mon, 27 Jan 2003 11:14:49 -0500
Received: from quark.didntduck.org ([216.43.55.190]:36870 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP
	id <S267217AbTA0QOt>; Mon, 27 Jan 2003 11:14:49 -0500
Message-ID: <3E355D1F.1080007@didntduck.org>
Date: Mon, 27 Jan 2003 11:23:59 -0500
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla/5.0 (Windows; U; WinNT4.0; en-US; rv:1.2.1) Gecko/20021130
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mauricio Martinez <mauricio@coe.neu.edu>
CC: linux-kernel@vger.kernel.org
Subject: Re: OOPS in read_cd... what to do?
References: <Pine.GSO.4.33.0301270937370.18209-100000@Amps.coe.neu.edu>
In-Reply-To: <Pine.GSO.4.33.0301270937370.18209-100000@Amps.coe.neu.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mauricio Martinez wrote:
> I reported twice (Jan 15 the last time) to this list a kernel oops when
> reading a CD in a SONY CDU-31A unit with kernels 2.4.18 - 2.4.20 (and
> probably all the 2.4 series), which works fine on 2.2.x (and even
> 1.2.x!!), maybe the maintainer of this part os the code is offline... Are
> there any alternatives to fix this problem? Thank you.

Drivers for older hardware like this are more than likely unmaintained, 
and suffer from bit-rot.  I don't have this hardware, but I can offer a 
bit of analysis to help you debug this further.  From the oops message 
in your previous email, it looks like the oops occurred on line 1326 of 
cdu31a.c.  From the stack dump, I can see that input_data was called 
with bytesleft=0x4000.  This caused readahead_buffer + bytesleft to go 
past the end of the module and oops.

--
				Brian Gerst

