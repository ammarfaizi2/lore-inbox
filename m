Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280964AbRKCPVi>; Sat, 3 Nov 2001 10:21:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280965AbRKCPV1>; Sat, 3 Nov 2001 10:21:27 -0500
Received: from sitar.i-cable.com ([210.80.60.11]:3217 "HELO sitar.i-cable.com")
	by vger.kernel.org with SMTP id <S280964AbRKCPVS>;
	Sat, 3 Nov 2001 10:21:18 -0500
Message-ID: <3BE4B4D5.5090704@rcn.com.hk>
Date: Sun, 04 Nov 2001 11:24:05 +0800
From: David Chow <davidchow@rcn.com.hk>
User-Agent: Mozilla/5.0 (Windows; U; Win98; en-GB; rv:0.9.2) Gecko/20010726 Netscape6/6.1
X-Accept-Language: en-gb
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: wrong domainname in ipconfig.c
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear all,

In ipconfig.c the GNU extension'ss domainname (ypdomain or nisdomain) in 
system_utsname.domainname is wrong after executing the function "__init 
ip_auto_config_setup()". It has mixed with the dnsdomain passed from the 
kernel command line "ip=". This also results in the wrong hostname which 
is passed by the command line, this make commands like "domainname", 
"nisdomainname", "dnsdomainname" and "hostname" output wrong 
information. The dns domainname should be read from the hostname from 
the "uname()" call. The nisdomainname stored in the 
system_utsname.domainname is a GNU extension. To support passing 
nisdomain from the kernel command line should use a separate parameter 
such as "nisdomain=" or "ypdomain=" where #ifdef _GNU_SOURCE will enable 
compile-in of this bootup option to allow bootup configure with the 
nisdomain. I will make a patch for this later. If anyone is also doing 
the same thing, please give me a notice. Thanks.

regards,

DC

