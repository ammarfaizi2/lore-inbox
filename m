Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290589AbSARDlw>; Thu, 17 Jan 2002 22:41:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290591AbSARDle>; Thu, 17 Jan 2002 22:41:34 -0500
Received: from topic-gw2.topic.com.au ([203.37.31.2]:24826 "EHLO
	mailhost.topic.com.au") by vger.kernel.org with ESMTP
	id <S290589AbSARDlV>; Thu, 17 Jan 2002 22:41:21 -0500
Date: Fri, 18 Jan 2002 14:40:55 +1100
From: Jason Thomas <jason@topic.com.au>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: network connections stalls
Message-ID: <20020118034055.GD5653@topic.com.au>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="HlL+5n6rz5pIUxbD"
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--HlL+5n6rz5pIUxbD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

please CC me I'm not on the list.

Hi,

I need some help with this bug.

I've got two athlon boxes which produce this same problem with all
kernels from 2.4.18-pre4 back to 2.4.0 which is a far as I went.

It seems to be only triggered by a particular string of binary data
which I've narrowed down (it came from a pdf document). which I'll
attach now. its 735 bytes, if I change it or remove a byte it doesn't
cause the problem.

The machines are both athlon 1.1GHZ on ASUS A7V133 mobo's, thats the
only simularitys between them ones scsi the others ide ones a via-rhine
nic and the other is a tulip.

output from tcpump:
14:28:25.184415 hathor.tsa.46893 > alhazred.tsa.1234: S 2668390347:2668390347(0) win 5840 <mss 1460,sackOK,timestamp 18451301 0,nop,wscale 0> (DF)
14:28:25.184461 alhazred.tsa.1234 > hathor.tsa.46893: S 2674935738:2674935738(0) ack 2668390348 win 5792 <mss 1460,sackOK,timestamp 102014 18451301,nop,wscale 0> (DF)
14:28:25.184616 hathor.tsa.46893 > alhazred.tsa.1234: . ack 1 win 5840 <nop,nop,timestamp 18451301 102014> (DF)
14:28:25.184954 hathor.tsa.46893 > alhazred.tsa.1234: P 1:735(734) ack 1 win 5840 <nop,nop,timestamp 18451301 102014> (DF)
14:28:25.393041 hathor.tsa.46893 > alhazred.tsa.1234: P 1:735(734) ack 1 win 5840 <nop,nop,timestamp 18451322 102014> (DF)
14:28:25.813051 hathor.tsa.46893 > alhazred.tsa.1234: P 1:735(734) ack 1 win 5840 <nop,nop,timestamp 18451364 102014> (DF)
14:28:26.653052 hathor.tsa.46893 > alhazred.tsa.1234: P 1:735(734) ack 1 win 5840 <nop,nop,timestamp 18451448 102014> (DF)
14:28:28.333082 hathor.tsa.46893 > alhazred.tsa.1234: P 1:735(734) ack 1 win 5840 <nop,nop,timestamp 18451616 102014> (DF)
14:28:31.182923 hathor.tsa.46893 > alhazred.tsa.1234: F 735:735(0) ack 1 win 5840 <nop,nop,timestamp 18451901 102014> (DF)
14:28:31.182947 alhazred.tsa.1234 > hathor.tsa.46893: . ack 1 win 5792 <nop,nop,timestamp 102614 18451616,nop,nop,sack sack 1 {735:736} > (DF)
14:28:31.693138 hathor.tsa.46893 > alhazred.tsa.1234: P 1:735(734) ack 1 win 5840 <nop,nop,timestamp 18451952 102614> (DF)
14:28:38.413253 hathor.tsa.46893 > alhazred.tsa.1234: P 1:735(734) ack 1 win 5840 <nop,nop,timestamp 18452624 102614> (DF)
14:28:51.853463 hathor.tsa.46893 > alhazred.tsa.1234: P 1:735(734) ack 1 win 5840 <nop,nop,timestamp 18453968 102614> (DF)
14:29:18.733896 hathor.tsa.46893 > alhazred.tsa.1234: P 1:735(734) ack 1 win 5840 <nop,nop,timestamp 18456656 102614> (DF)

I've tried this with both netcat and rsh, which produce the same
results. I've also tested sending the same string from a solaris box
which results in the same error.

I've also reduce the kernel to a bare minimum of drivers. I can send the
.config if anyone wants it.

The problem does not show its self on the loopback device.

I am willing to put some effort into debugging this if someone can help
me figure out where to start. If there is any other info required let me
know.

Thanks.

--HlL+5n6rz5pIUxbD
Content-Type: application/octet-stream
Content-Disposition: attachment; filename="testdata.dat"
Content-Transfer-Encoding: base64

7wAAAAAAAAAAE/3///+JAAAA1f/////9AwAAAAAAAAP8/////xUAAAAAAAAAP//////9AwAA
AAAAAAAN/8WN////////1QAAAHAAAACA/////////1b/wAAAAAAAAAAAAAAN/////6kAAAAA
AAAAN////////////ysAAAAAAAAAv/////0EAAAAAAAAAAAAAAAAAAAAAAAAAADA////////
/////wwAAAAAAAAAAAAAAAAAbP////////////8rAAAAAAAAAJ///////////8kAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAF///fwAAAAAAAACA///////////XAAAAAAAAABb//////////0EA
AAAAAAAAAAAAAG//////////gAAAAAAAAJX/////rAAAAAAAAAAx/////////4db////////
RQAAAAAAAAC/////1QAAAAAAAAAABP3////AAAAAAAAAAACg/1f/////////5wAAAAAAAACA
//////////9r/2IAAAAAAAAAAAA6/////3QAAAAAAAAAdP//////////6wAAAAAAAAAA4f//
/9UAAAAAAAAAH///////////////////////////////ZwAAAAAAAAAAAAAAAAAASv//////
//////QAAAAAAAAAANX////////////////////9AwAAAAAAAADD////////////NwAAAAAA
AACs//////////+7AAAAAAAAAEH//////////0EAAAAAAAAAAAAAAACz////////gAAAAAAA
AJv/////jQAAAAAAAACP////////////////////fwAAAAAAAACV////kwAAAAAAAAAAAMD/
//+VAAAAAAAAACH/e+L/////////2wAAAAAAAACA//////////+fz+EAAAAAAAAAAABw////
/0EAAAAAAAAAm///////////wAAAAAAAAAAf/////5c=

--HlL+5n6rz5pIUxbD--
