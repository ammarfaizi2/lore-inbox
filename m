Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264891AbSIWC7Q>; Sun, 22 Sep 2002 22:59:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264895AbSIWC7Q>; Sun, 22 Sep 2002 22:59:16 -0400
Received: from c16598.thoms1.vic.optusnet.com.au ([210.49.243.217]:20870 "HELO
	pc.kolivas.net") by vger.kernel.org with SMTP id <S264891AbSIWC7N>;
	Sun, 22 Sep 2002 22:59:13 -0400
Message-ID: <1032750261.3d8e84b5486a9@kolivas.net>
Date: Mon, 23 Sep 2002 13:04:21 +1000
From: Con Kolivas <conman@kolivas.net>
To: linux-kernel@vger.kernel.org
Subject: [BENCHMARK] gcc3.2 v 2.95.3 (contest and linux-2.5.38)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I performed contest benchmarks on kernel 2.5.38 when the kernel is compiled with
gcc3.2 to gcc2.95.3

warning: The following benchmarks may be disturbing to some viewers:

No Load:
Kernel                  Time            CPU
2.5.38                  68.25           99%
2.5.38-gcc32            103.03          99%

Process Load:
Kernel                  Time            CPU
2.5.38                  71.60           95%
2.5.38-gcc32            112.98          91%

IO Half Load:
Kernel                  Time            CPU
2.5.38                  81.26           90%
2.5.38-gcc32            168.25          70%

IO Full Load:
Kernel                  Time            CPU
2.5.38                  170.21          42%
2.5.38-gcc32            1405.25         8%

Mem Load:
Kernel                  Time            CPU
2.5.38                  104.22          70%
2.5.38-gcc32            153.00          74%

Both kernels had identical configs and contest was run using gcc2.95.3 (I can't
see how this would affect it but tell me if you think it will). The only
difference was the original 2.5.38 was compiled with gcc2.95.3 and -gcc32 was
compiled with gcc3.2

Note the lower performance even with noload, and the totally abysmal performance
under full load. See the logs below for the page fault differences too.

Full logs follow:
2.5.38:
noload Time: 68.25  CPU: 99%  Major Faults: 204613  Minor Faults: 255906
process_load Time: 71.60  CPU: 95%  Major Faults: 204019  Minor Faults: 255238
io_halfmem Time: 81.26  CPU: 90%  Major Faults: 204019  Minor Faults: 255325
Was writing number 4 of a 112Mb sized io_load file after 90 seconds
io_fullmem Time: 170.21  CPU: 42%  Major Faults: 204019  Minor Faults: 255272
Was writing number 6 of a 224Mb sized io_load file after 194 seconds
mem_load Time: 104.22  CPU: 70%  Major Faults: 204120  Minor Faults: 256271

2.5.38-gcc32:
noload Time: 103.03  CPU: 99%  Major Faults: 237750  Minor Faults: 439982
process_load Time: 112.98  CPU: 91%  Major Faults: 236958  Minor Faults: 439030
io_halfmem Time: 168.25  CPU: 70%  Major Faults: 236958  Minor Faults: 439261
Was writing number 16 of a 112Mb sized io_load file after 202 seconds
io_fullmem Time: 1405.25  CPU: 8%  Major Faults: 237199  Minor Faults: 440233
Was writing number 59 of a 224Mb sized io_load file after 1496 seconds
mem_load Time: 153.00  CPU: 74%  Major Faults: 237863  Minor Faults: 440524

These are disturbing to me. 

Comments?
Con.
