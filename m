Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266973AbRGMVOJ>; Fri, 13 Jul 2001 17:14:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266980AbRGMVOA>; Fri, 13 Jul 2001 17:14:00 -0400
Received: from sciurus.rentec.com ([192.5.35.161]:2491 "EHLO
	sciurus.rentec.com") by vger.kernel.org with ESMTP
	id <S266973AbRGMVNv>; Fri, 13 Jul 2001 17:13:51 -0400
Date: Fri, 13 Jul 2001 17:13:55 -0400 (EDT)
From: Dirk Wetter <dirkw@rentec.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
cc: Mike Galbraith <mikeg@wen-online.de>, <riel@conectiva.com.br>,
        <linux-kernel@vger.kernel.org>
Subject: Re: dead mem walking ;-) 
In-Reply-To: <Pine.LNX.4.21.0107121730190.2582-100000@freak.distro.conectiva>
Message-ID: <Pine.LNX.4.33.0107131631260.15876-101000@monster000.rentec.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="96532003-400096395-995058835=:15876"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--96532003-400096395-995058835=:15876
Content-Type: TEXT/PLAIN; charset=US-ASCII

On Thu, 12 Jul 2001, Marcelo Tosatti wrote:

> > > And that is what is eating the system performance.
> >
> > does it bring up the load up to 30 and make the machine unusable?
> > (kswapd was also sometimes in the top-list of CPU hogs, but since i
> > sorted it by memory...)
>
> Yes. Obviously that should not happen.
>
> What you're seeing _is_ a problem.

thx for the ACK. :)) in the beginning of the week i felt like
nobody really cares.

> > > Can you please show us the output of /proc/meminfo when the system is
> > > behaving badly ?
> >
> > hold on, we set s.th. up....
>
> Ok, thanks.

here (attachement) it is, first the "top" output (sorry for the
length, but i don't want to cut too much. even more info i can make av.
upon request).

interesting is, that after i killed one job, some minutes later the
the machine went to sleep again for a ~20 minutes:

 4:49pm  up  1:55,  2 users,  load average: 21.05, 18.29, 16.79
55 processes: 52 sleeping, 3 running, 0 zombie, 0 stopped
CPU0 states:  0.1% user, 99.115% system,  0.22% nice,  0.59% idle
CPU1 states:  0.4% user, 99.106% system,  0.64% nice,  0.23% idle
Mem:  4057236K av, 4050648K used,    6588K free,       0K shrd,    2884K buff
Swap: 14337736K av, 2785436K used, 11552300K free                 3428484K cached
  PID  PPID USER     PRI  SIZE SWAP  RSS SHARE   D STAT %CPU %MEM   TIME COMMA
 1374  1295 usersid 15 2140M 1.2G 924M  353M  0M R N  99.7 23.3  77:56 ceqsim
 2089   760 root      19  1048    4 1044   824  55 R     0.2  0.0   0:00 top
    1     0 root       8    76   12   64    64   4 S     0.0  0.0   0:02 init

a few secs later i did cat /proc/meminfo (machine was in the middle of
waking up again):

        total:    used:    free:  shared: buffers:  cached:
Mem:  4154609664 4148756480  5853184        0  2953216 3529117696
Swap: 1796939776 2871406592 3220500480
MemTotal:      4057236 kB
MemFree:          5716 kB
MemShared:           0 kB
Buffers:          2884 kB
Cached:        3446404 kB
Active:         378132 kB
Inact_dirty:   2944608 kB
Inact_clean:    126548 kB
Inact_target:      560 kB
HighTotal:     3211200 kB
HighFree:         2036 kB
LowTotal:       846036 kB
LowFree:          3680 kB
SwapTotal:    14337736 kB
SwapFree:     11533628 kB


readprofile showed even worse statistics for __get_swap_page afterwards:

884565 total                                      1.0268
488027 __get_swap_page                          897.1085
385109 default_idle                             7405.9423
  1920 do_anonymous_page                          6.2338
  1198 file_read_actor                            4.8306
   872 si_swapinfo                                5.0698
   782 do_softirq                                 5.7500
   779 skb_copy_bits                              0.9143
   317 statm_pgd_range                            0.8087
   302 __rdtsc_delay                             10.7857


why was the machine hung with that one job? memorywise that job was
only 2.1GB on my 4GB machine. is it also due to the __get_swap_page
issue or are the "Inact_dirty" pages related to that?


cheers,
	~dirkw







--96532003-400096395-995058835=:15876
Content-Type: APPLICATION/x-gtar; name="vm.gz"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.33.0107131713550.15876@monster000.rentec.com>
Content-Description: 
Content-Disposition: attachment; filename="vm.gz"

H4sICJBfTzsCA3ZtAO2Za2/bVhKGv/NXTAsEmxZe4twv+uYk3tToajewUxTo
lwUt0bbWkqgVqXrTX993SJGiHEq2gKRYLKokAsk5Z3gu7zMzR0lIj6RZLYg2
K1KCFrPlGZGkTZmvcTEvsillv+br7C4fkUqlOCOZCnyLVIfESVqti0lelnk5
IuupnOf5ara8Qytab5bL+lLTb8XiZpajE5VVsVrl0+Tth5/4Jqu4I7lUvNq+
UppUv6LyU1nlizO24G45m6CzD3w9m85z7i37vWXXO6Rmr7foehu21L3H+QK9
jLBeafcjpnfGN0oa8SO7maIjkRURttt1nte3+MBa3q8bq1YS1pvN7W1y/Zit
Rhi21t637roOjbudkf3RZx9vMRZYJ9nkHmtD9OHyHb74+6fri6u6zYerS6Lr
y18u6Prn8w9EV9fXdP3D+dUFbO/o+uP5R3qFZaFX44sxHn28HF/Q23+Ox+cJ
Se0N9lRFW69SOZvizuGvFuN6nNhS956sNAbt8Owd/QMtbBrJyFSihRoJTZP8
P+VsAXfKapilMz13Fu5UOOZOp4Hdicad6tzxatYzhGKKotouSWxWcP+r/hZY
AL5WPDJR+xMjIeihxEZMk+T1Kl/fFutFtpzkNCupeGBpVwXd52vs5bJ4pFn1
l5Kq7O4O8qQVpF1SVtK3vLDfjr5LktOQ8DUSmpEw4ikSuoeEPQUJu0NC1TLu
RG1Z7o2o3SEker21SNVeb9X1NtzqCBJahz4SOthjSEh9FIlgcG06JLSJQnt1
AAlpfZBfE4khDRto2KsxqQAhy9SwhoUItYavag07IKFNGj9DYogwu3WnvWZ3
esidQiRJfePOHEdCiSNIXP1cL1oaekjIHRKPOWXrvNZ+Rrf5I5X5pFhOS5pD
L2t6nFX3pL630o/fbHmYLam6z4kdNHtwlswLoJRVW6/MCZ2YPFxNiq1JkV8s
efRJ2Q//lu+2Wq+pGSDF9Hr7PVJMr7fvODuYPMx+8lCHSVFSqyOkSOFlUD1S
lLNRHiTFma9KyqAWgcoz4VmJ1PW0qFotDpMXSHphx8QKhETUezLKIqZ32aN2
p2JLnjlOXmR3bt+dUaGXjHxqODCKJ+4w3eS16YItVbMFyFlOt6PndMJUTFYb
ui/uOgTsyxHQNQKhRkAlzvYRcKqHgNohIJ9FoCdiHfbqJ7ML99al9jkEjHjS
u6uf7A6ggwiEPQRCOIYANz6MgHX47Oon5T2oOFQ/KQFvDMz/GAJ6r0IxOwQO
ZAuvzZi8qjUr3sMB0scuWygJ9SuEtEaz/tl6bOvOdO68M3tEWXZnG3euR1Tk
Z96Jp7P1EcPBVnPBylfYIdxqahbYPpkthIrMsyyo2FSrTUWoySBq8LGB6r5j
0hgd36KjjqODwj4gcSAOR7CR+vAnO3+y8//NDueiZf7fqgVoknEyuuWCzbcc
ffMNtWUZJyZmJm12qrwvNvNpcpM3NmSuVTFbwtltk9XKajaf15UfH4LWeVYW
y7KGNCPz/g0toIfZMm9ABamqrfP0c0kO66LO6ozNyU6kMSQ+9ln1oseqO6XU
E7uTfoyoIUOPN7H7paC5HqD1eH/R6++O82r2DkbGHzsYKWmPlXtKQtPcouVV
KR2DOcSrxas5OvyRvD5/9EDhrVoFqz1ehwBTDBjqsxgjKNOAFoBJ1+PV41CE
kO94cZ8t9+SAO6d6vHKx1brD6GJX7v21+dAih6RviySRFgcaHJ1GSbvgVVFl
8xFf8f7UF7wxuCjvcabCE95ZDAVPmj0ZtaKR1jgRHaauIQGU8c46ACGUCro+
CG61wsNXTgSBiKO8jS6IVik+uqij967fuH3G7/nYDa9TKT28YcvfmlFuf07x
gSNQY7neDnz3EWx5082jO1pEVVveNvPa/V4lbGgs55Nq9mve66Ks1fV7LpfZ
pPrXdLauPtVmG73CnDvLZJ5ny9H+CBpLla3v8qo28UIZtvwwu7vvTVUDGiVE
a+lPVQZpQ/2evxeP/dWhgN1oVgeWvdXxPLb6Pbzsu04tqK1l16lvYdEoltUX
Fo2RBopGaIFSjMN8Y08FKJjwfugCSreYlgrhc80oGQLCiWEFRjTiFQgnqAZG
26zLCaohfuOAapR12ko1oBoESOhmUDXgwphh1YSw3c3PVKODahTwctVwjOu0
8ULVoI9x4STVKLw+NCNg1Wg30vYrqEbHaLnKQF0pMOU91SASIAopr7XVyDxu
QDVaQDiSxaV9ABrWRXeSarh+PV01ZlA1zkXW76BqfOxHlJ1qpGBshlRjBP6Y
YdV4Ld0foRotGq2/XDUixC05rBojUcF+edWEoA1HW7LeW+1EXzUAV8KEKhhL
LlBaD6nGIMcZg+iPHO3QxhlxmmrQ4XTVRDekGi8g4jCoGiGkG1QN9tn3tbFT
jY7aSHVANcKJk1Wj4+mq2fJxgmqM38anpDk11D/oNj9s1WeJm2zywP8xMscC
0eubT/SAIwGfBrjhv4sbnNJrvfmvUBDhSouAdET4p4UUdi+5YVpCseBidCya
wTCFxRI43KoaXRsjHpwgOBvbUHCS4DgsDglOG6GGwhTvkTBiQHBMjPFqUHDe
hRAGBYfDhj8xTCkTbfOelwsOJG/HdoLgtPJNsk5+B/2nG0RXHgAA
--96532003-400096395-995058835=:15876--
