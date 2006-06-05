Return-Path: <SRS0=UgzX=7Y=vger.kernel.org=linux-kernel-owner@srs.kundenserver.de>
thread-index: AcaIOVtSvIGBEhVrTg2ct4dgJJ0R0w==
Delivery-Date: Mon, 05 Jun 2006 02:29:24 +0200
From: "Grant Coady" <gcoady.lk@gmail.com>
Illegal-Object: Syntax error in To: address found on vger.kernel.org:To:	"J.A.  =?ISO-8859-1?Q?=20Magall=F3n=22?= <jamagallon@ono.com>"		^-missing closing '"' in token
Message-ID: <000201c68839$5b54b7f0$0b64a8c0@mehnertedv.local>
Cc: "Andrew Morton" <akpm@osdl.org>, <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.17-rc5-mm3
Date: Mon, 5 Jun 2006 02:45:35 +0200
Organization: http://bugsplatter.mine.nu/
Reply-To: "Grant Coady" <gcoady.lk@gmail.com>
References: <20060603232004.68c4e1e3.akpm@osdl.org> <20060605012842.3d58095f@werewolf.auna.net>
In-Reply-To: <20060605012842.3d58095f@werewolf.auna.net>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain;
	charset="ISO-8859-1"
Content-Transfer-Encoding: 8bit
Content-Class: urn:content-classes:message
Sender: <linux-kernel-owner@vger.kernel.org>
Importance: normal
Priority: normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.2663
X-Mailing-List: linux-kernel@vger.kernel.org
To: <unlisted-recipients:@osdl.org>, <no.To-header.on.input@osdl.org>,
        "IMB Recipient 1" <mspop3connector.stefan@mehnert-edv.de>
X-OriginalArrivalTime: 05 Jun 2006 00:45:35.0531 (UTC) FILETIME=[5B7167B0:01C68839]
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:5df3490ebbf8888d64f9643250eb1e65

On Mon, 5 Jun 2006 01:28:42 +0200, "J.A. Magallón" <jamagallon@ono.com> wrote:

>On Sat, 3 Jun 2006 23:20:04 -0700, Andrew Morton <akpm@osdl.org> wrote:
>
>> 
>> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17-rc5/2.6.17-rc5-mm3/
>> 
>> - Lots of PCI and USB updates
>> 
>> - The various lock validator, stack backtracing and IRQ management problems
>>   are converging, but we're not quite there yet.
>> 
>
>I got this with -mm2, is it supposed to be cured in -mm3 ? I still have to
>try with mm3:
>
>Jun  2 14:34:39 annwn kernel: Console: colour VGA+ 80x60
>Jun  2 14:34:39 annwn kernel: ------------------------
>Jun  2 14:34:39 annwn kernel: | Locking API testsuite:
>Jun  2 14:34:39 annwn kernel: ----------------------------------------------------------------------------
>Jun  2 14:34:39 annwn kernel:                                  | spin |wlock |rlock |mutex | wsem | rsem |
>Jun  2 14:34:39 annwn kernel:   --------------------------------------------------------------------------
>Jun  2 14:34:39 annwn kernel:                      A-A deadlock:failed|failed|failed|failed|failed|failed|
>Jun  2 14:34:39 annwn kernel:                  A-B-B-A deadlock:failed|failed|  ok  |failed|failed|failed|
>Jun  2 14:34:39 annwn kernel:              A-B-B-C-C-A deadlock:failed|failed|  ok  |failed|failed|failed|
>Jun  2 14:34:39 annwn kernel:              A-B-C-A-B-C deadlock:failed|failed|  ok  |failed|failed|failed|
>Jun  2 14:34:39 annwn kernel:          A-B-B-C-C-D-D-A deadlock:failed|failed|  ok  |failed|failed|failed|
>Jun  2 14:34:39 annwn kernel:          A-B-C-D-B-D-D-A deadlock:failed|failed|  ok  |failed|failed|failed|
>Jun  2 14:34:39 annwn kernel:          A-B-C-D-B-C-D-A deadlock:failed|failed|  ok  |failed|failed|failed|
>Jun  2 14:34:39 annwn kernel:                     double unlock:failed|failed|failed|failed|failed|failed|
>Jun  2 14:34:39 annwn kernel:                  bad unlock order:failed|failed|failed|failed|failed|failed|
>Jun  2 14:34:39 annwn kernel:   --------------------------------------------------------------------------
>Jun  2 14:34:39 annwn kernel:               recursive read-lock:             |  ok  |             |failed|
>Jun  2 14:34:39 annwn kernel:   --------------------------------------------------------------------------
>Jun  2 14:34:39 annwn kernel:      hard-irqs-on + irq-safe-A/12:failed|failed|  ok  |
>Jun  2 14:34:39 annwn kernel:      soft-irqs-on + irq-safe-A/12:failed|failed|  ok  |
>Jun  2 14:34:39 annwn kernel:      hard-irqs-on + irq-safe-A/21:failed|failed|  ok  |
>Jun  2 14:34:39 annwn kernel:      soft-irqs-on + irq-safe-A/21:failed|failed|  ok  |
>Jun  2 14:34:39 annwn kernel:        sirq-safe-A => hirqs-on/12:failed|failed|  ok  |
>Jun  2 14:34:39 annwn kernel:        sirq-safe-A => hirqs-on/21:failed|failed|  ok  |
>Jun  2 14:34:39 annwn kernel:          hard-safe-A + irqs-on/12:failed|failed|  ok  |
>Jun  2 14:34:39 annwn kernel:          soft-safe-A + irqs-on/12:failed|failed|  ok  |
>
>(all tests failed like this...)
>
>Jun  2 14:34:39 annwn kernel: --------------------------------------------------------
>Jun  2 14:34:39 annwn kernel: 141 out of 206 testcases failed, as expected. |
>Jun  2 14:34:39 annwn kernel: ----------------------------------------------------
>
>Expected ? Uh ?

I got something like that here before turning on all the test options, 
suggest '  --  ' for non-selected tests.  More info, first four files:
<http://bugsplatter.mine.nu/test/linux-2.6/sempro/?M=D>

dmesg, false positives:

<http://bugsplatter.mine.nu/test/linux-2.6/sempro/dmesg-2.6.17-rc5-mm3a.gz>:

------------------------
| Locking API testsuite:
----------------------------------------------------------------------------
                                 | spin |wlock |rlock |mutex | wsem | rsem |
  --------------------------------------------------------------------------
                     A-A deadlock:failed|failed|failed|failed|failed|failed|
                 A-B-B-A deadlock:failed|failed|  ok  |failed|failed|failed|
             A-B-B-C-C-A deadlock:failed|failed|  ok  |failed|failed|failed|
             A-B-C-A-B-C deadlock:failed|failed|  ok  |failed|failed|failed|
         A-B-B-C-C-D-D-A deadlock:failed|failed|  ok  |failed|failed|failed|
         A-B-C-D-B-D-D-A deadlock:failed|failed|  ok  |failed|failed|failed|
         A-B-C-D-B-C-D-A deadlock:failed|failed|  ok  |failed|failed|failed|
                    double unlock:failed|failed|failed|failed|failed|failed|
                 bad unlock order:failed|failed|failed|failed|failed|failed|
  --------------------------------------------------------------------------
              recursive read-lock:             |  ok  |             |failed|
  --------------------------------------------------------------------------
     hard-irqs-on + irq-safe-A/12:failed|failed|  ok  |
     soft-irqs-on + irq-safe-A/12:failed|failed|  ok  |
     hard-irqs-on + irq-safe-A/21:failed|failed|  ok  |
     soft-irqs-on + irq-safe-A/21:failed|failed|  ok  |

and dmesg, okay:
<http://bugsplatter.mine.nu/test/linux-2.6/sempro/dmesg-2.6.17-rc5-mm3a-2.gz>:
------------------------
| Locking API testsuite:
----------------------------------------------------------------------------
                                 | spin |wlock |rlock |mutex | wsem | rsem |
  --------------------------------------------------------------------------
                     A-A deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
                 A-B-B-A deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
             A-B-B-C-C-A deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
             A-B-C-A-B-C deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
         A-B-B-C-C-D-D-A deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
         A-B-C-D-B-D-D-A deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
         A-B-C-D-B-C-D-A deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
                    double unlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
                 bad unlock order:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
  --------------------------------------------------------------------------
              recursive read-lock:             |  ok  |             |  ok  |
  --------------------------------------------------------------------------
                non-nested unlock:  ok  |  ok  |  ok  |  ok  |
  ------------------------------------------------------------
     hard-irqs-on + irq-safe-A/12:  ok  |  ok  |  ok  |
     soft-irqs-on + irq-safe-A/12:  ok  |  ok  |  ok  |
     hard-irqs-on + irq-safe-A/21:  ok  |  ok  |  ok  |
     soft-irqs-on + irq-safe-A/21:  ok  |  ok  |  ok  |

Grant.
