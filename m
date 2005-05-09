Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261164AbVEIJPE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261164AbVEIJPE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 May 2005 05:15:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261154AbVEIJPE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 May 2005 05:15:04 -0400
Received: from mail.ebeling.ee ([194.204.16.123]:28589 "EHLO
	virus.scan.test.ebeling.ee") by vger.kernel.org with ESMTP
	id S261164AbVEIJL0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 May 2005 05:11:26 -0400
Message-ID: <427F29F9.7060203@solo.ee>
Date: Mon, 09 May 2005 12:14:33 +0300
From: Aleksei Kurepin <niemi@solo.ee>
User-Agent: Debian Thunderbird 1.0 (X11/20050116)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: hi, problem with Canyon portable HDD with USB interface
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://rafb.net/paste/results/pwjLOh43.html

It's work on Windows OS
--- mailto ---
niemi[at]solo.ee


*****
Pasted by: Niemi from 80.235.101.226
Language: Plain Text
Description: Canyon USB portable HDD mount error
Remove line numbers <http://rafb.net/paste/results/pwjLOh43.nln.html>
Download as Text <http://rafb.net/paste/results/pwjLOh43.txt>
Other recent pastes <http://rafb.net/paste/results.html>
Create new paste <http://rafb.net/paste/>

1
2
3
4
5
6
7
8
9
10
11
12
13
14
15
16
17
18
19
20
21
22
23
24
25
26
27
28
29
30
31
32
33
34
35
36
37
38
39
40
41
42
43
44
45
46
47
48
49
50
51
52
53
54
55
56
57
58
59
60
61
62
63
64
65
66
67
68
69
70
71
72
73
74
75
76
77
78
79
80
81
82
83
84
85
86
87
88
89
90
91
92
93
94
95
96
97
98
99
100
101
102
103
104
105
106
107
108
109
110
111
112
113
114
115
116
117
118
119
120
121
122
123
124
125
126
127
128
129
130
131
132
133
134
135
136
137
138
139
140
141
142
143
144
145
146
147
148
149
150
151
152
153
154
155
156
157
158
159
160
161
162
163
164
165
166
167
168
169
170
171
172
173
174
175
176
177
178
179
180
181
182
183
184
185
186
187
188
189
190
191
192
193
194
195
196
197
198
199
200
201
202
203
204
205
206
207
208
209
210
211
212
213
214
215
216
217
218
219
220
221
222
223
224
225
226
227
228
229
230
231
232
233
234
235
236
237
238
239
240
241
242
243
244
245
246
247
248
249
250
251
252
253
254
255
256
257
258
259
260
261
262
263
264
265
266
267
268
269
270
271
272
273
274
275
276
277
278
279
280
281
282
283
284
285
286
287
288
289
290
291
292
293
294
295
296
297
298
299
300
301
302
303
304
305
306
307
308
309
310
311
312
313
314
315
316
317
318
319
320
321
322
323
324
325
326
327
328
329
330
331
332
333
334
335
336
337
338
339
340
341
342
343
344
345
346
347
348
349
350
351
352
353
354
355
356
357
358
359
360
361
362
363
364
365
366
367
368
369
370
371
372
373
374
375
376
377
378
379
380
381
382
383
384
385
386
387
388
389
390
391
392
393
394
395
396
397
398
399
400
401
402
403
404
405
406
407
408
409
410
411
412
413
414
415
416
417
418
419
420
421
422
423
424
425
426
427
428
429
430
431
432
433
434
435
436
437
438
439
440
441
442
443
444
445
446
447
448
449
450
451
452
453
454
455
456
457
458
459
460
461
462
463
464
465
466
467
468
469
470
471
472
473
474
475
476
477
478
479
480
481
482
483
484
485
486
487
488
489
490
491
492
493
494
495
496
497
498
499
500
501
502
503
504
505
506
507
508
509
510
511
512
513
514
515
516
517
518
519
520
521
522
523
524
525
526
527
528
529
530
531
532
533
534
535
536
537
538
539
540
541
542
543
544
545
546
547
548
549
550
551
552
553
554
555
556
557
558
559
560
561
562
563
564
565
566
567
568
569
570
571
572
573
574
575
576
577
578
579
580
581
582
583
584
585
586
587
588
589
590
591
592
593
594
595
596
597
598
599
600
601
602
603
604
605
606
607
608
609
610
611
612
613
614
615
616
617
618
619
620
621
622
623
624
625
626
627
628
629
630
631
632
633
634
635
636
637
638
639
640
641
642
643
644
645
646
647
648
649
650
651
652
653
654
655
656
657
658
659
660
661
662
663
664
665
666
667
668
669
670
671
672
673
674
675
676
677
678
679
680
681
682
683
684
685
686
687
688
689
690
691
692
693
694
695
696
697
698
699
700
701
702
703
704
705
706
707
708
709
710
711
712
713
714
715
716
717
718
719
720
721
722
723
724
725
726
727
728
729
730
731
732
733
734
735

	

mailto: linux-kernel@vger.kernel.org
Can't mount Canyon portable HDD with USB interface
--
freya:~# mount -t vfat /dev/sda /media/usbdrive
mount: wrong fs type, bad option, bad superblock on /dev/sda,
       or too many mounted file systems
freya:~# mount -t vfat /dev/sda1 /media/usbdrive
mount: wrong fs type, bad option, bad superblock on /dev/sda1,
       or too many mounted file systems
freya:~# mount -t ntfs /dev/sda1 /media/usbdrive
mount: wrong fs type, bad option, bad superblock on /dev/sda1,
       or too many mounted file systems
freya:~# mount -t ntfs /dev/sda /media/usbdrive
mount: wrong fs type, bad option, bad superblock on /dev/sda,
       or too many mounted file systems
freya:~# mount -t msdos /dev/sda /media/usbdrive
mount: wrong fs type, bad option, bad superblock on /dev/sda,
       or too many mounted file systems
freya:~# mount -t msdos /dev/sda1 /media/usbdrive
mount: wrong fs type, bad option, bad superblock on /dev/sda1,
       or too many mounted file systems
/*
* freya:~# mount -t vfat /dev/sdb1 /media/usbdrive
* mount: /dev/sdb1 is not a valid block device
* freya:~# mount -t vfat /dev/sdb /media/usbdrive
* mount: /dev/sdb is not a valid block device
*/
--
freya:~# fdisk /dev/sda
Unable to read /dev/sda
freya:~# fdisk -l /dev/sda
freya:~#[nothing]
freya:~# file -k -L -s /dev/sda
/dev/sda: ERROR: cannot read `/dev/sda' (Input/output error)
freya:~# file -k -L -s /dev/sda1
/dev/sda1: ERROR: cannot read `/dev/sda1' (Input/output error)
 
 
--
freya:~# ls /proc/bus/usb/
001  002  003  devices  drivers
--
freya:~# cat /proc/bus/usb/devices
T:  Bus=03 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=480 MxCh= 6
B:  Alloc=  0/800 us ( 0%), #Int=  0, #Iso=  0
D:  Ver= 2.00 Cls=09(hub  ) Sub=00 Prot=01 MxPS= 8 #Cfgs=  1
P:  Vendor=0000 ProdID=0000 Rev= 2.04
C:* #Ifs= 1 Cfg#= 1 Atr=40 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   2 Ivl=256ms
T:  Bus=02 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=12  MxCh= 3
B:  Alloc=  0/900 us ( 0%), #Int=  0, #Iso=  0
D:  Ver= 1.10 Cls=09(hub  ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=0000 ProdID=0000 Rev= 0.00
S:  Product=USB OHCI Root Hub
S:  SerialNumber=d09aa000
C:* #Ifs= 1 Cfg#= 1 Atr=40 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   2 Ivl=255ms
T:  Bus=01 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=12  MxCh= 3
B:  Alloc=  0/900 us ( 0%), #Int=  0, #Iso=  0
D:  Ver= 1.10 Cls=09(hub  ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=0000 ProdID=0000 Rev= 0.00
S:  Product=USB OHCI Root Hub
S:  SerialNumber=d0879000
C:* #Ifs= 1 Cfg#= 1 Atr=40 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   2 Ivl=255ms
--
freya:~# cat /proc/bus/usb/drivers
         usbdevfs
         hub
         usb-storage
--
freya:~# uname -a
Linux freya 2.4.27-2-386 #1 Thu Jan 20 10:55:08 JST 2005 i686 GNU/Linux
--
freya:~# cat /proc/version
Linux version 2.4.27-2-386 (horms@charles.lab.ultramonkey.org) (gcc version 3.3.5 (Debian 1:3.3.5-6)) #1 Thu Jan 20 10:55:08 JST 2005
--
freya:~# cat /proc/modules
nls_cp437               4284   3 (autoclean)
ntfs                   45088   0 (autoclean)
umsdos                 22340   0 (autoclean)
vfat                    8748   0 (autoclean)
sd_mod                 10764   0 (autoclean)
msdos                   4588   0 (autoclean) [umsdos]
fat                    27576   0 (autoclean) [umsdos vfat msdos]
usb-storage            54496   0
isofs                  22996   0 (autoclean)
apm                     8428   1 (autoclean)
af_packet              11048   1 (autoclean)
ehci-hcd               14764   0 (unused)
usb-ohci               16488   0 (unused)
usbcore                52268   1 [usb-storage ehci-hcd usb-ohci]
i810_audio             21372   2
ac97_codec             11252   0 [i810_audio]
soundcore               3268   2 [i810_audio]
ide-scsi                8272   0
scsi_mod               86052   3 [sd_mod usb-storage ide-scsi]
sis900                 11052   1
crc32                   2848   0 [sis900]
ide-cd                 27072   0
cdrom                  26212   0 [ide-cd]
rtc                     5768   0 (autoclean)
reiserfs              152944   1 (autoclean)
ide-detect               288   0 (autoclean) (unused)
sis5513                 9872   1 (autoclean)
ide-disk               12448   2 (autoclean)
ide-core               91832   2 (autoclean) [usb-storage ide-scsi ide-cd ide-detect sis5513 ide-disk]
unix                   12752  76 (autoclean)
 
--
freya:~# lsmod
Module                  Size  Used by    Not tainted
nls_cp437               4284   1  (autoclean)
ntfs                   45088   0  (autoclean)
umsdos                 22340   0  (autoclean)
vfat                    8748   0  (autoclean)
sd_mod                 10764   0  (autoclean)
msdos                   4588   0  (autoclean) [umsdos]
fat                    27576   0  (autoclean) [umsdos vfat msdos]
usb-storage            54496   0
isofs                  22996   0  (autoclean)
apm                     8428   1  (autoclean)
af_packet              11048   1  (autoclean)
ehci-hcd               14764   0  (unused)
usb-ohci               16488   0  (unused)
usbcore                52268   1  [usb-storage ehci-hcd usb-ohci]
i810_audio             21372   2
ac97_codec             11252   0  [i810_audio]
soundcore               3268   2  [i810_audio]
ide-scsi                8272   0
scsi_mod               86052   3  [sd_mod usb-storage ide-scsi]
sis900                 11052   1
crc32                   2848   0  [sis900]
ide-cd                 27072   0
cdrom                  26212   0  [ide-cd]
rtc                     5768   0  (autoclean)
reiserfs              152944   1  (autoclean)
ide-detect               288   0  (autoclean) (unused)
sis5513                 9872   1  (autoclean)
ide-disk               12448   2  (autoclean)
ide-core               91832   2  (autoclean) [usb-storage ide-scsi ide-cd ide-detect sis5513 ide-disk]
unix                   12752  76  (autoclean)
--
freya:~# cat /proc/ioports
0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0070-007f : rtc
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
0376-0376 : ide1
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(auto)
b000-bfff : PCI Bus #01
  bc00-bc7f : Silicon Integrated Systems [SiS] SiS330 [Xabre] PCI/AGP VGA Display Adapter
d400-d4ff : Silicon Integrated Systems [SiS] SiS900 10/100 Ethernet
  d400-d4ff : sis900
d800-d87f : Silicon Integrated Systems [SiS] Sound Controller
  d800-d83f : SiS 7012
dc00-dcff : Silicon Integrated Systems [SiS] Sound Controller
  dc00-dcff : SiS 7012
ff00-ff0f : Silicon Integrated Systems [SiS] 5513 [IDE]
  ff00-ff07 : ide0
  ff08-ff0f : ide1
--
freya:~# cat /proc/iomem
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000cc000-000d3fff : Extension ROM
000f0000-000fffff : System ROM
00100000-0ffeffff : System RAM
  00100000-0020b52d : Kernel code
  0020b52e-0027e143 : Kernel data
0fff0000-0fff7fff : ACPI Tables
0fff8000-0fffffff : ACPI Non-volatile Storage
bfa00000-cfbfffff : PCI Bus #01
  c0000000-c7ffffff : Silicon Integrated Systems [SiS] SiS330 [Xabre] PCI/AGP VGA Display Adapter
cfd00000-cfefffff : PCI Bus #01
  cfec0000-cfefffff : Silicon Integrated Systems [SiS] SiS330 [Xabre] PCI/AGP VGA Display Adapter
cfff7000-cfff7fff : Silicon Integrated Systems [SiS] SiS900 10/100 Ethernet
  cfff7000-cfff7fff : sis900
cfff9000-cfff9fff : Silicon Integrated Systems [SiS] USB 1.0 Controller
  cfff9000-cfff9fff : usb-ohci
cfffa000-cfffafff : Silicon Integrated Systems [SiS] USB 2.0 Controller
  cfffa000-cfffafff : ehci_hcd
cfffb000-cfffbfff : Silicon Integrated Systems [SiS] USB 1.0 Controller (#2)
  cfffb000-cfffbfff : usb-ohci
d0000000-d3ffffff : Silicon Integrated Systems [SiS] 746 Host
ffee0000-ffefffff : reserved
fffc0000-ffffffff : reserved
--
freya:~# lspci -vvv
0000:00:00.0 Host bridge: Silicon Integrated Systems [SiS] 746 Host (rev 02)
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
        Latency: 0
        Region 0: Memory at d0000000 (32-bit, non-prefetchable) [size=64M]
        Capabilities: [c0] AGP version 3.0
                Status: RQ=32 Iso- ArqSz=2 Cal=3 SBA+ ITACoh- GART64- HTrans- 64bit- FW- AGP3+ Rate=x4,x8
                Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- Rate=<none>
 
0000:00:01.0 PCI bridge: Silicon Integrated Systems [SiS] SG86C202 (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Bus: primary=00, secondary=01, subordinate=02, sec-latency=64
        I/O behind bridge: 0000b000-0000bfff
        Memory behind bridge: cfd00000-cfefffff
        Prefetchable memory behind bridge: bfa00000-cfbfffff
        BridgeCtl: Parity- SERR+ NoISA- VGA+ MAbort- >Reset- FastB2B-
 
0000:00:02.0 ISA bridge: Silicon Integrated Systems [SiS] SiS85C503/5513 (LPC Bridge) (rev 25)
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
 
0000:00:02.5 IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE] (prog-if 80 [Master])
        Subsystem: Silicon Integrated Systems [SiS] SiS5513 EIDE Controller (A,B step)
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 128
        Region 4: I/O ports at ff00 [size=16]
 
0000:00:02.7 Multimedia audio controller: Silicon Integrated Systems [SiS] Sound Controller (rev a0)
        Subsystem: C-Media Electronics Inc: Unknown device 0300
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (13000ns min, 2750ns max)
        Interrupt: pin C routed to IRQ 10
        Region 0: I/O ports at dc00 [size=256]
        Region 1: I/O ports at d800 [size=128]
        Capabilities: [48] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=55mA PME(D0-,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
 
0000:00:03.0 USB Controller: Silicon Integrated Systems [SiS] USB 1.0 Controller (rev 0f) (prog-if 10 [OHCI])
        Subsystem: Micro-Star International Co., Ltd.: Unknown device 5470
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (20000ns max), Cache Line Size: 0x08 (32 bytes)
        Interrupt: pin A routed to IRQ 5
        Region 0: Memory at cfff9000 (32-bit, non-prefetchable) [size=4K]
 
0000:00:03.1 USB Controller: Silicon Integrated Systems [SiS] USB 1.0 Controller (rev 0f) (prog-if 10 [OHCI])
        Subsystem: Micro-Star International Co., Ltd.: Unknown device 5470
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (20000ns max), Cache Line Size: 0x08 (32 bytes)
        Interrupt: pin B routed to IRQ 5
        Region 0: Memory at cfffb000 (32-bit, non-prefetchable) [size=4K]
 
0000:00:03.2 USB Controller: Silicon Integrated Systems [SiS] USB 2.0 Controller (prog-if 20 [EHCI])
        Subsystem: Silicon Integrated Systems [SiS] USB 2.0 Controller
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (20000ns max)
        Interrupt: pin D routed to IRQ 11
        Region 0: Memory at cfffa000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D3 PME-Enable- DSel=0 DScale=0 PME-
 
0000:00:04.0 Ethernet controller: Silicon Integrated Systems [SiS] SiS900 PCI Fast Ethernet (rev 90)
        Subsystem: Silicon Integrated Systems [SiS] SiS900 10/100 Ethernet Adapter
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (13000ns min, 2750ns max)
        Interrupt: pin A routed to IRQ 11
        Region 0: I/O ports at d400 [size=256]
        Region 1: Memory at cfff7000 (32-bit, non-prefetchable) [size=4K]
        Expansion ROM at cffc0000 [disabled] [size=128K]
        Capabilities: [40] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
 
0000:01:00.0 VGA compatible controller: Silicon Integrated Systems [SiS] 330 [Xabre] PCI/AGP VGA Display Adapter (rev 01) (prog-if 00 [VGA])
        Subsystem: Elitegroup Computer Systems: Unknown device 0330
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 71 (750ns min, 4000ns max)
        BIST result: 00
        Region 0: Memory at c0000000 (32-bit, prefetchable) [size=128M]
        Region 1: Memory at cfec0000 (32-bit, non-prefetchable) [size=256K]
        Region 2: I/O ports at bc00 [size=128]
        Capabilities: [40] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [50] AGP version 3.0
                Status: RQ=256 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW- AGP3+ Rate=x4,x8
                Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- Rate=<none>
--
freya:~# cat /proc/scsi/scsi
Attached devices:
Host: scsi1 Channel: 00 Id: 00 Lun: 00
  Vendor: TOSHIBA  Model: MK3018GAS        Rev: 0811
  Type:   Direct-Access                    ANSI SCSI revision: 02
 
--
freya:~# cat /proc/filesystems
nodev   rootfs
nodev   bdev
nodev   proc
nodev   sockfs
nodev   tmpfs
nodev   shm
nodev   pipefs
        ext2
        cramfs
nodev   ramfs
nodev   devfs
nodev   devpts
        reiserfs
nodev   usbdevfs
nodev   usbfs
        iso9660
        msdos
        vfat
        umsdos
        ntfs
-- full dmesg output
freya:~# dmesg
ue before enabling vector: 00000000
ESR value after enabling vector: 00000000
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 1500.1065 MHz.
..... host bus clock speed is 200.0142 MHz.
cpu: 0, clocks: 2000142, slice: 1000071
CPU0<T0:2000128,T1:1000048,D:9,S:1000071,C:2000142>
ACPI: Subsystem revision 20040326
ACPI: Interpreter disabled.
PCI: PCI BIOS revision 2.10 entry at 0xfdb01, last bus=2
PCI: Probing PCI hardware
PCI: ACPI tables contain no PCI IRQ routing entries
PCI: Probing PCI hardware (bus 00)
PCI: Using IRQ router SIS96x [1039/0008] at 00:02.0
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
VFS: Disk quotas vdquot_6.5.1
devfs: v1.12c (20020818) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x0
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with HUB-6 MANY_PORTS MULTIPORT SHARE_IRQ SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
COMX: driver version 0.85 (C) 1995-1999 ITConsult-Pro Co. <info@itc.hu>
RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
Initializing Cryptographic API
NET4: Linux TCP/IP 1.0 for NET4.0
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 32768)
Linux IP multicast router 0.06 plus PIM-SM
RAMDISK: cramfs filesystem found at block 0
RAMDISK: Loading 3788 blocks [1 disk] into ram disk... done.
Freeing initrd memory: 3788k freed
VFS: Mounted root (cramfs filesystem).
Freeing unused kernel memory: 96k freed
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ide: late registration of driver.
SIS5513: IDE controller at PCI slot 00:02.5
SIS5513: chipset revision 0
SIS5513: not 100% native mode: will probe irqs later
SIS5513: SiS 962/963 MuTIOL IDE UDMA133 controller
    ide0: BM-DMA at 0xff00-0xff07, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xff08-0xff0f, BIOS settings: hdc:DMA, hdd:DMA
hda: SAMSUNG SP0411N, ATA DISK drive
blk: queue d0825b60, I/O limit 4095Mb (mask 0xffffffff)
hdc: DVD-ROM DDU1621, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: attached ide-disk driver.
hda: 78242976 sectors (40060 MB) w/2048KiB Cache, CHS=4870/255/63, UDMA(100)
Partition check:
 /dev/ide/host0/bus0/target0/lun0: p1 < p5 > p2
reiserfs: found format "3.6" with standard journal
reiserfs: checking transaction log (device ide0(3,2)) ...
for (ide0(3,2))
reiserfs: replayed 26 transactions in 0 seconds
ide0(3,2):Using r5 hash to sort names
reiserfs: found format "3.6" with standard journal
reiserfs: checking transaction log (device ide0(3,2)) ...
for (ide0(3,2))
ide0(3,2):Using r5 hash to sort names
Adding Swap: 505976k swap-space (priority -1)
Real Time Clock Driver v1.10f
hdc: attached ide-cdrom driver.
hdc: ATAPI 40X DVD-ROM drive, 512kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
sis900.c: v1.08.07 11/02/2003
PCI: Found IRQ 11 for device 00:04.0
eth0: VIA 6103 PHY transceiver found at address 1.
eth0: Using transceiver found at address 1 as default
eth0: SiS 900 PCI Fast Ethernet at 0xd400, IRQ 11, 00:0a:e6:9f:d7:2d.
SCSI subsystem driver Revision: 1.00
scsi0 : SCSI host adapter emulation for IDE ATAPI devices
Intel 810 + AC97 Audio, version 1.01, 10:59:53 Jan 20 2005
PCI: Found IRQ 10 for device 00:02.7
i810: SiS 7012 found at IO 0xd800 and 0xdc00, MEM 0x0000 and 0x0000, IRQ 10
i810_audio: Audio Controller supports 6 channels.
i810_audio: Defaulting to base 2 channel mode.
i810_audio: Resetting connection 0
ac97_codec: AC97  codec, id: CMI97 (CMedia)
AC97 codec does not have proper volume support.
i810_audio: only 48Khz playback available.
i810_audio: AC'97 codec 0, new EID value = 0x05c6
i810_audio: AC'97 codec 0, DAC map configured, total channels = 6
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
PCI: Found IRQ 5 for device 00:03.1
usb-ohci.c: USB OHCI at membase 0xd0879000, IRQ 5
usb-ohci.c: usb-00:03.1, Silicon Integrated Systems [SiS] USB 1.0 Controller (#2)
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 3 ports detected
PCI: Found IRQ 5 for device 00:03.0
usb-ohci.c: USB OHCI at membase 0xd09aa000, IRQ 5
usb-ohci.c: usb-00:03.0, Silicon Integrated Systems [SiS] USB 1.0 Controller
usb.c: new USB bus registered, assigned bus number 2
hub.c: USB hub found
hub.c: 3 ports detected
PCI: Found IRQ 11 for device 00:03.2
ehci_hcd 00:03.2: Silicon Integrated Systems [SiS] USB 2.0 Controller
ehci_hcd 00:03.2: irq 11, pci mem d09b1000
usb.c: new USB bus registered, assigned bus number 3
PCI: cache line size of 64 is not supported by device 00:03.2
ehci_hcd 00:03.2: USB 2.0 enabled, EHCI 1.00, driver 2003-Dec-29/2.4
hub.c: USB hub found
hub.c: 6 ports detected
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
shpchp: acpi_shpchprm:get_device PCI ROOT HID fail=0x1001
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
pciehp: acpi_pciehprm:get_device PCI ROOT HID fail=0x1001
eth0: Media Link On 100mbps full-duplex
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16)
spurious 8259A interrupt: IRQ7.
device eth0 entered promiscuous mode
device eth0 left promiscuous mode
device eth0 entered promiscuous mode
device eth0 left promiscuous mode
device eth0 entered promiscuous mode
device eth0 left promiscuous mode
hub.c: new USB device 00:03.2-3, assigned address 2
usb.c: USB device 2 (vend/prod 0x5e3/0x702) is not claimed by any active driver.
Initializing USB Mass Storage driver...
usb.c: registered new driver usb-storage
scsi1 : SCSI emulation for USB Mass Storage devices
  Vendor: TOSHIBA   Model: MK3018GAS         Rev: 0811
  Type:   Direct-Access                      ANSI SCSI revision: 02
WARNING: USB Mass Storage data integrity not assured
USB Mass Storage device found at 2
USB Mass Storage support registered.
usb.c: USB disconnect on device 00:03.2-3 address 2
hub.c: new USB device 00:03.2-3, assigned address 3
WARNING: USB Mass Storage data integrity not assured
USB Mass Storage device found at 3
Attached scsi disk sda at scsi1, channel 0, id 0, lun 0
SCSI device sda: 58605120 512-byte hdwr sectors (30006 MB)
 /dev/scsi/host1/bus0/target0/lun0: p1
FAT: bogus logical sector size 64543
VFS: Can't find a valid FAT filesystem on dev 08:00.
FAT: bogus logical sector size 64543
VFS: Can't find a valid FAT filesystem on dev 08:00.
FAT: bogus logical sector size 64543
VFS: Can't find a valid FAT filesystem on dev 08:00.
usb.c: USB disconnect on device 00:03.2-3 address 3
hub.c: new USB device 00:03.2-3, assigned address 4
WARNING: USB Mass Storage data integrity not assured
USB Mass Storage device found at 4
usb.c: USB disconnect on device 00:03.2-3 address 4
Sony CDU-535: probing base address 340
Did not find a Sony CDU-535 drive
sbpcd-0 [01]:  sbpcd.c v4.63 Andrew J. Kroll <ag784@freenet.buffalo.edu> Wed Jul 26 04:24:10 EDT 2000
sbpcd-0 [02]:  Scanning 0x340 (LaserMate)...
sbpcd-0 [03]:  Scanning 0x340 (SoundBlaster)...
sbpcd-0 [04]:  No drive found.
Sony CDU-535: probing base address 340
Did not find a Sony CDU-535 drive
sbpcd-0 [01]:  sbpcd.c v4.63 Andrew J. Kroll <ag784@freenet.buffalo.edu> Wed Jul 26 04:24:10 EDT 2000
sbpcd-0 [02]:  Scanning 0x340 (LaserMate)...
sbpcd-0 [03]:  Scanning 0x340 (SoundBlaster)...
sbpcd-0 [04]:  No drive found.
sbpcd-0 [01]:  sbpcd.c v4.63 Andrew J. Kroll <ag784@freenet.buffalo.edu> Wed Jul 26 04:24:10 EDT 2000
sbpcd-0 [02]:  Scanning 0x340 (LaserMate)...
sbpcd-0 [03]:  Scanning 0x340 (SoundBlaster)...
sbpcd-0 [04]:  No drive found.
usb-ohci.c: USB suspend: usb-00:03.0
usb-ohci.c: USB suspend: usb-00:03.1
ehci_hcd 00:03.2: suspend to state 3
PCI: Found IRQ 10 for device 00:02.7
ac97_codec: AC97  codec, id: CMI97 (CMedia)
AC97 codec does not have proper volume support.
usb-ohci.c: USB continue: usb-00:03.0 from host wakeup
usb-ohci.c: USB continue: usb-00:03.1 from host wakeup
ehci_hcd 00:03.2: resume
eth0: Media Link On 100mbps full-duplex
Device 08:01 not ready.
 I/O error: dev 08:01, sector 0
FAT: unable to read boot sector
Device 08:01 not ready.
 I/O error: dev 08:01, sector 0
Device 08:01 not ready.
 I/O error: dev 08:01, sector 64
Device 08:01 not ready.
 I/O error: dev 08:01, sector 0
FAT: unable to read boot sector
Device 08:01 not ready.
 I/O error: dev 08:01, sector 0
FAT: unable to read boot sector
Device 08:01 not ready.
 I/O error: dev 08:01, sector 0
FAT: unable to read boot sector
Device 08:01 not ready.
 I/O error: dev 08:01, sector 0
FAT: unable to read boot sector
Device 08:01 not ready.
 I/O error: dev 08:01, sector 0
FAT: unable to read boot sector
Device 08:01 not ready.
 I/O error: dev 08:01, sector 0
FAT: unable to read boot sector
Device 08:00 not ready.
 I/O error: dev 08:00, sector 0
FAT: unable to read boot sector
Device 08:01 not ready.
 I/O error: dev 08:01, sector 0
FAT: unable to read boot sector
Device 08:00 not ready.
 I/O error: dev 08:00, sector 0
FAT: unable to read boot sector
Device 08:00 not ready.
 I/O error: dev 08:00, sector 0
FAT: unable to read boot sector
Device 08:00 not ready.
 I/O error: dev 08:00, sector 0
Device 08:00 not ready.
 I/O error: dev 08:00, sector 64
Device 08:00 not ready.
 I/O error: dev 08:00, sector 0
FAT: unable to read boot sector
Device 08:00 not ready.
 I/O error: dev 08:00, sector 0
FAT: unable to read boot sector
Device 08:01 not ready.
 I/O error: dev 08:01, sector 0
Device 08:01 not ready.
 I/O error: dev 08:01, sector 64
Device 08:01 not ready.
 I/O error: dev 08:01, sector 0
FAT: unable to read boot sector
Device 08:01 not ready.
 I/O error: dev 08:01, sector 0
FAT: unable to read boot sector
Device 08:01 not ready.
 I/O error: dev 08:01, sector 0
FAT: unable to read boot sector
Device 08:01 not ready.
 I/O error: dev 08:01, sector 0
FAT: unable to read boot sector
Device 08:01 not ready.
 I/O error: dev 08:01, sector 0
FAT: unable to read boot sector
Device 08:00 not ready.
 I/O error: dev 08:00, sector 0
FAT: unable to read boot sector
Device 08:00 not ready.
 I/O error: dev 08:00, sector 0
FAT: unable to read boot sector
Device 08:01 not ready.
 I/O error: dev 08:01, sector 0
FAT: unable to read boot sector
Device 08:01 not ready.
 I/O error: dev 08:01, sector 0
Device 08:01 not ready.
 I/O error: dev 08:01, sector 64
Device 08:01 not ready.
 I/O error: dev 08:01, sector 0
FAT: unable to read boot sector
Device 08:01 not ready.
 I/O error: dev 08:01, sector 0
FAT: unable to read boot sector
Device 08:01 not ready.
 I/O error: dev 08:01, sector 0
FAT: unable to read boot sector
Device 08:01 not ready.
 I/O error: dev 08:01, sector 0
FAT: unable to read boot sector
Device 08:00 not ready.
 I/O error: dev 08:00, sector 0
FAT: unable to read boot sector
Device 08:00 not ready.
 I/O error: dev 08:00, sector 0
FAT: unable to read boot sector
Device 08:00 not ready.
 I/O error: dev 08:00, sector 0
FAT: unable to read boot sector
Device 08:00 not ready.
 I/O error: dev 08:00, sector 0
Device 08:00 not ready.
 I/O error: dev 08:00, sector 64
Device 08:00 not ready.
 I/O error: dev 08:00, sector 0
FAT: unable to read boot sector
Device 08:00 not ready.
 I/O error: dev 08:00, sector 0
FAT: unable to read boot sector
Device 08:00 not ready.
 I/O error: dev 08:00, sector 0
Device 08:00 not ready.
 I/O error: dev 08:00, sector 64
Device 08:00 not ready.
 I/O error: dev 08:00, sector 0
FAT: unable to read boot sector
Device 08:00 not ready.
 I/O error: dev 08:00, sector 0
FAT: unable to read boot sector
Device 08:00 not ready.
 I/O error: dev 08:00, sector 0
FAT: unable to read boot sector
Device 08:00 not ready.
 I/O error: dev 08:00, sector 0
FAT: unable to read boot sector
UMSDOS: msdos_read_super failed, mount aborted.
Device 08:00 not ready.
 I/O error: dev 08:00, sector 0
FAT: unable to read boot sector
Device 08:00 not ready.
 I/O error: dev 08:00, sector 0
Device 08:00 not ready.
 I/O error: dev 08:00, sector 64
Device 08:00 not ready.
 I/O error: dev 08:00, sector 0
FAT: unable to read boot sector
Device 08:00 not ready.
 I/O error: dev 08:00, sector 0
FAT: unable to read boot sector
Device 08:00 not ready.
 I/O error: dev 08:00, sector 0
FAT: unable to read boot sector
UMSDOS: msdos_read_super failed, mount aborted.
Device 08:01 not ready.
 I/O error: dev 08:01, sector 0
FAT: unable to read boot sector
Device 08:01 not ready.
 I/O error: dev 08:01, sector 0
Device 08:00 not ready.
 I/O error: dev 08:00, sector 0
FAT: unable to read boot sector
Device 08:00 not ready.
 I/O error: dev 08:00, sector 0
FAT: unable to read boot sector
Device 08:00 not ready.
 I/O error: dev 08:00, sector 0
FAT: unable to read boot sector
Device 08:01 not ready.
 I/O error: dev 08:01, sector 0
FAT: unable to read boot sector
Device 08:01 not ready.
 I/O error: dev 08:01, sector 0
FAT: unable to read boot sector
Device 08:00 not ready.
 I/O error: dev 08:00, sector 0
Device 08:01 not ready.
 I/O error: dev 08:01, sector 0
NTFS driver v1.1.22 [Flags: R/O MODULE]
NTFS: unkown option 'default'
NTFS: unkown option 'default'
Device 08:01 not ready.
 I/O error: dev 08:01, sector 0
NTFS: Reading super block failed
Device 08:01 not ready.
 I/O error: dev 08:01, sector 0
FAT: unable to read boot sector
Device 08:00 not ready.
 I/O error: dev 08:00, sector 0
FAT: unable to read boot sector
Device 08:01 not ready.
 I/O error: dev 08:01, sector 0
Device 08:00 not ready.
 I/O error: dev 08:00, sector 0
Device 08:00 not ready.
 I/O error: dev 08:00, sector 0
Device 08:01 not ready.
 I/O error: dev 08:01, sector 0
Device 08:00 not ready.
 I/O error: dev 08:00, sector 0
Device 08:00 not ready.
 I/O error: dev 08:00, sector 0
Device 08:01 not ready.
 I/O error: dev 08:01, sector 0
Device 08:00 not ready.
 I/O error: dev 08:00, sector 0
Device 08:01 not ready.
 I/O error: dev 08:01, sector 0
FAT: unable to read boot sector
Device 08:00 not ready.
 I/O error: dev 08:00, sector 0
FAT: unable to read boot sector
Device 08:01 not ready.
 I/O error: dev 08:01, sector 0
FAT: unable to read boot sector
Device 08:01 not ready.
 I/O error: dev 08:01, sector 0
NTFS: Reading super block failed
Device 08:00 not ready.
 I/O error: dev 08:00, sector 0
NTFS: Reading super block failed
Device 08:00 not ready.
 I/O error: dev 08:00, sector 0
FAT: unable to read boot sector
Device 08:01 not ready.
 I/O error: dev 08:01, sector 0
FAT: unable to read boot sector
Device 08:00 not ready.
 I/O error: dev 08:00, sector 0
Device 08:00 not ready.
 I/O error: dev 08:00, sector 0
Device 08:00 not ready.
 I/O error: dev 08:00, sector 0
Device 08:01 not ready.
 I/O error: dev 08:01, sector 0
--


