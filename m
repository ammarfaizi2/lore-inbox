Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318954AbSHMHI0>; Tue, 13 Aug 2002 03:08:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318955AbSHMHI0>; Tue, 13 Aug 2002 03:08:26 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:56587 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S318954AbSHMHIZ>; Tue, 13 Aug 2002 03:08:25 -0400
Message-ID: <3D58B14A.5080500@zytor.com>
Date: Tue, 13 Aug 2002 00:12:10 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1a) Gecko/20020702
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, viro@math.psu.edu
Subject: klibc and logging
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Okay... I think klibc is starting to get pretty much to the point where 
it will need to be, although I'm sure there will be plenty of bugs once 
we start using it heavily -- and it still needs RPC support code for 
mounting NFS :(

However, I'm wondering what to do about logging.  Kernel log messages 
get stored away until klogd gets started, but early userspace may need 
some way to log messages -- and syslog is obviously not running.  The 
easiest way to do this would probably be to be able to write to 
/proc/kmsg (which probably really should be /dev/kmsg) and push messages 
onto the kernel's message queue; but we could also have a dedicated 
location in the initramfs for writing logs, and do it all in userspace. 
  In the latter case there needs to be a convention to make sure this 
file is actually present in the namespace at the time syslog starts, and 
of course syslog needs to know about it...

	-hpa

