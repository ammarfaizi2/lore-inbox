Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265790AbRGFC61>; Thu, 5 Jul 2001 22:58:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265796AbRGFC6S>; Thu, 5 Jul 2001 22:58:18 -0400
Received: from louie.udel.edu ([128.175.2.33]:492 "HELO mail.eecis.udel.edu")
	by vger.kernel.org with SMTP id <S265790AbRGFC6A>;
	Thu, 5 Jul 2001 22:58:00 -0400
Message-ID: <3B452849.9000500@udel.edu>
Date: Thu, 05 Jul 2001 22:54:01 -0400
From: Manish Jain <mjain@udel.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.2-2 i686; en-US; rv:0.9.1) Gecko/20010608
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: window field in TCP header.
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I am running linux kernal 2.4.2 .
My query is concerning the manner in which the TCP code
handles the initial window size value ( RWIN ) in the TCP header.

I observed that RWIN that the client
announces is 5840 bytes in the <SYN> packet irrespective of what value
I set using the setsockopt .

Is there any particular reason for this ?
It seems to me as a too small a value.

Secondly, any way to get around this ?

I checked the /proc/sys/net/core/* where the defaults are set.
rmem_default is set to 65535 . Similarly wmem_default.

Further more, when I checked the complete packet trace using tcpdump for 
the FTP data connection ( for a large file transfer ) , it seems that 
though TCP starts with a RWIN of 5840 in the <SYN> segement but keeps on 
increasing the RWIN as the connection progresses upto 47784 .

Next, I modified FTP code to set the initial window field to 500 K bytes.
The window field in the <SYN> packet should have been 64 K and wscale = 3.
But again the window field was 5840 bytes and wscale = 1.

After some packets were transferred , the window field increased upto
47784 but not beyond that.

Now the RFC 1323 says that the receiver will left-shift window field
of every incoming segemet by wscale bits.

Left shifting 47784 by 1 bit would in no way offer me th desired window 
( 500 K bytes ).

Is there some thing that I am doing wrong or is there something wrong in
the TCP implementation ?


Please CC any replies to my email id.

Thanks,

Manish



