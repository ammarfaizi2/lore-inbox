Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292907AbSB0TpO>; Wed, 27 Feb 2002 14:45:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292897AbSB0ToJ>; Wed, 27 Feb 2002 14:44:09 -0500
Received: from flaske.stud.ntnu.no ([129.241.56.72]:34237 "EHLO
	flaske.stud.ntnu.no") by vger.kernel.org with ESMTP
	id <S292907AbSB0TmY>; Wed, 27 Feb 2002 14:42:24 -0500
Date: Wed, 27 Feb 2002 20:42:22 +0100
From: =?iso-8859-1?Q?Thomas_Lang=E5s?= <tlan@stud.ntnu.no>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BETA] First test release of Tigon3 driver
Message-ID: <20020227204222.B27400@stud.ntnu.no>
Reply-To: linux-kernel@vger.kernel.org
In-Reply-To: <20020227125611.A20415@stud.ntnu.no> <20020227.040653.58455636.davem@redhat.com> <20020227132454.B24996@stud.ntnu.no> <20020227.042845.54186884.davem@redhat.com> <20020227.042845.54186884.davem@redhat.com>; <20020227170321.B22422@stud.ntnu.no> <3C7D0510.2C300D12@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C7D0510.2C300D12@redhat.com>; from arjanv@redhat.com on Wed, Feb 27, 2002 at 04:10:56PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven:
> google for nttcp
> runs a nice tcp performance test...

I did some more benchmarking as Jeff Garzik requested:
[S: sending host, R: receiving host]

1. S: Broadcom's GPLed driver
   R: Miller/Garzik's GPLed driver
2. S: Broadcom's GPLed driver
   R: Broadcom's GPLed driver
3. S: Miller/Garzik's GPLed driver
   R: Broadcom's GPLed driver

(scenario 4, Miller/Garzik on both ends has already been tested, see another
email in this thread).

__Scenario 1__
UDP:
kiwi:~/nttcp-1.47# ./nttcp -T -v -r -u 129.241.57.161
nttcp-l: nttcp, version 1.47
nttcp-l: Pid=4354
nttcp-l: send window size = 65535
nttcp-l: receive window size = 65535
nttcp-l: buflen=4096, bufcnt=2048, dataport=5038/udp
nttcp-l: try to get outstanding messages from 1 remote clients
nttcp-1: Pid=1930, InetPeer= 129.241.57.160
nttcp-1: Optionline="nttcp@-t@-l4096@-n2048@-u@-v@-f@%9b%8.2rt%8.2ct%12.4rbr%12.4cbr%8c%10.2rcr%10.1ccr@-N1"
nttcp-l: try to get outstanding messages from 1 remote clients
nttcp-1: from ?: "129.241.57.160" (=dataport: 5038)
nttcp-l: try to get outstanding messages from 1 remote clients
nttcp-1: send window size = 65535
nttcp-1: receive window size = 65535
nttcp-l: try to get outstanding messages from 1 remote clients
nttcp-1: buflen=4096, bufcnt=2048, dataport=5038/udp

nttcp-l: got EOF
nttcp-l: received 5910528 bytes
     Bytes  Real s   CPU s Real-MBit/s  CPU-MBit/s   Calls  Real-C/s   CPU-C/s
l  5910528    0.07    0.08    656.3334    591.0528    1444  20043.59   18050.0
nttcp-l: try to get outstanding messages from 1 remote clients
nttcp-1: transmitted 8388608 bytes
nttcp-l: try to get outstanding messages from 1 remote clients
1  8388608    0.07    0.07    962.3826    958.6981    2051  29412.61   29300.0
nttcp-1: exiting

TCP:
kiwi:~/nttcp-1.47# ./nttcp -T -v -r 129.241.57.161
nttcp-l: nttcp, version 1.47
nttcp-l: Pid=4355
nttcp-l: accept from 129.241.57.161
nttcp-l: send window size = 16384
nttcp-l: receive window size = 87380
nttcp-l: buflen=4096, bufcnt=2048, dataport=5038/tcp
nttcp-l: try to get outstanding messages from 1 remote clients
nttcp-1: Pid=1931, InetPeer= 129.241.57.160
nttcp-1: Optionline="nttcp@-t@-l4096@-n2048@-v@-f@%9b%8.2rt%8.2ct%12.4rbr%12.4cbr%8c%10.2rcr%10.1ccr@-N1"
nttcp-1: from ?: "129.241.57.160" (=dataport: 5038)
nttcp-1: send window size = 16384
nttcp-1: receive window size = 87380
nttcp-1: buflen=4096, bufcnt=2048, dataport=5038/tcp

nttcp-l: received 8388608 bytes
     Bytes  Real s   CPU s Real-MBit/s  CPU-MBit/s   Calls  Real-C/s   CPU-C/s
l  8388608    0.09    0.09    754.8719    745.6540    2073  23318.07   23033.3
nttcp-l: try to get outstanding messages from 1 remote clients
nttcp-1: transmitted 8388608 bytes
1  8388608    0.09    0.07    759.8205    958.6981    2048  23187.88   29257.1
nttcp-1: exiting



__Scenario 2__
UDP:
kiwi:~/nttcp-1.47# ./nttcp -T -v -r -u 129.241.57.161
nttcp-l: nttcp, version 1.47
nttcp-l: Pid=4409
nttcp-l: send window size = 65535
nttcp-l: receive window size = 65535
nttcp-l: buflen=4096, bufcnt=2048, dataport=5038/udp
nttcp-l: try to get outstanding messages from 1 remote clients
nttcp-1: Pid=2066, InetPeer= 129.241.57.160
nttcp-1: Optionline="nttcp@-t@-l4096@-n2048@-u@-v@-f@%9b%8.2rt%8.2ct%12.4rbr%12.4cbr%8c%10.2rcr%10.1ccr@-N1"
nttcp-l: try to get outstanding messages from 1 remote clients
nttcp-1: from ?: "129.241.57.160" (=dataport: 5038)
nttcp-l: try to get outstanding messages from 1 remote clients
nttcp-1: send window size = 65535
nttcp-1: receive window size = 65535
nttcp-l: try to get outstanding messages from 1 remote clients
nttcp-1: buflen=4096, bufcnt=2048, dataport=5038/udp

nttcp-l: got EOF
nttcp-l: received 6094848 bytes
     Bytes  Real s   CPU s Real-MBit/s  CPU-MBit/s   Calls  Real-C/s   CPU-C/s
l  6094848    0.07    0.07    678.4114    696.5541    1489  20717.39   21271.4
nttcp-l: try to get outstanding messages from 1 remote clients
nttcp-1: transmitted 8388608 bytes
nttcp-l: try to get outstanding messages from 1 remote clients
1  8388608    0.07    0.07    936.5683    958.6981    2051  28623.66   29300.0
nttcp-1: exiting

TCP:
kiwi:~/nttcp-1.47# ./nttcp -T -v -r 129.241.57.161   
nttcp-l: nttcp, version 1.47
nttcp-l: Pid=4410
nttcp-l: accept from 129.241.57.161
nttcp-l: send window size = 16384
nttcp-l: receive window size = 87380
nttcp-l: buflen=4096, bufcnt=2048, dataport=5038/tcp
nttcp-l: try to get outstanding messages from 1 remote clients
nttcp-1: Pid=2067, InetPeer= 129.241.57.160
nttcp-1: Optionline="nttcp@-t@-l4096@-n2048@-v@-f@%9b%8.2rt%8.2ct%12.4rbr%12.4cbr%8c%10.2rcr%10.1ccr@-N1"
nttcp-1: from ?: "129.241.57.160" (=dataport: 5038)
nttcp-1: send window size = 16384
nttcp-1: receive window size = 87380
nttcp-1: buflen=4096, bufcnt=2048, dataport=5038/tcp

nttcp-l: received 8388608 bytes
     Bytes  Real s   CPU s Real-MBit/s  CPU-MBit/s   Calls  Real-C/s   CPU-C/s
l  8388608    0.09    0.08    758.2323    838.8608    2061  23286.29   25762.5
nttcp-l: try to get outstanding messages from 1 remote clients
nttcp-1: transmitted 8388608 bytes
1  8388608    0.09    0.04    763.3294   1677.7216    2048  23294.96   51200.0
nttcp-1: exiting



__Scenario 3__
UDP:
kiwi:~/nttcp-1.47# ./nttcp -T -v -r -u 129.241.57.161   
nttcp-l: nttcp, version 1.47
nttcp-l: Pid=4509
nttcp-l: send window size = 65535
nttcp-l: receive window size = 65535
nttcp-l: buflen=4096, bufcnt=2048, dataport=5038/udp
nttcp-l: try to get outstanding messages from 1 remote clients
nttcp-1: Pid=2106, InetPeer= 129.241.57.160
nttcp-1: Optionline="nttcp@-t@-l4096@-n2048@-u@-v@-f@%9b%8.2rt%8.2ct%12.4rbr%12.4cbr%8c%10.2rcr%10.1ccr@-N1"
nttcp-l: try to get outstanding messages from 1 remote clients
nttcp-1: from ?: "129.241.57.160" (=dataport: 5038)
nttcp-l: try to get outstanding messages from 1 remote clients
nttcp-1: send window size = 65535
nttcp-1: receive window size = 65535
nttcp-l: try to get outstanding messages from 1 remote clients
nttcp-1: buflen=4096, bufcnt=2048, dataport=5038/udp

nttcp-l: got EOF
nttcp-l: received 8192000 bytes
     Bytes  Real s   CPU s Real-MBit/s  CPU-MBit/s   Calls  Real-C/s   CPU-C/s
l  8192000    0.07    0.07    914.3367    936.2286    2001  27917.29   28585.7
nttcp-l: try to get outstanding messages from 1 remote clients
nttcp-1: transmitted 8388608 bytes
nttcp-l: try to get outstanding messages from 1 remote clients
1  8388608    0.07    0.06    939.5448   1118.4811    2051  28714.63   34183.3
nttcp-1: exiting

TCP:
kiwi:~/nttcp-1.47# ./nttcp -T -v -r 129.241.57.161
nttcp-l: nttcp, version 1.47
nttcp-l: Pid=4512
nttcp-l: accept from 129.241.57.161
nttcp-l: send window size = 16384
nttcp-l: receive window size = 87380
nttcp-l: buflen=4096, bufcnt=2048, dataport=5038/tcp
nttcp-l: try to get outstanding messages from 1 remote clients
nttcp-1: Pid=2107, InetPeer= 129.241.57.160
nttcp-1: Optionline="nttcp@-t@-l4096@-n2048@-v@-f@%9b%8.2rt%8.2ct%12.4rbr%12.4cbr%8c%10.2rcr%10.1ccr@-N1"
nttcp-1: from ?: "129.241.57.160" (=dataport: 5038)
nttcp-1: send window size = 16384
nttcp-1: receive window size = 87380
nttcp-1: buflen=4096, bufcnt=2048, dataport=5038/tcp

nttcp-l: received 8388608 bytes
     Bytes  Real s   CPU s Real-MBit/s  CPU-MBit/s   Calls  Real-C/s   CPU-C/s
l  8388608    0.08    0.06    877.2286   1118.4811    2179  28483.29   36316.7
nttcp-l: try to get outstanding messages from 1 remote clients
nttcp-1: transmitted 8388608 bytes
1  8388608    0.08    0.04    872.2687   1677.7216    2048  26619.53   51200.0
nttcp-1: exiting


Hope this helps :)

-- 
Thomas
