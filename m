Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264142AbTDOWrt (for <rfc822;willy@w.ods.org>); Tue, 15 Apr 2003 18:47:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264143AbTDOWrt 
	(for <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2003 18:47:49 -0400
Received: from watch.techsource.com ([209.208.48.130]:60571 "EHLO
	techsource.com") by vger.kernel.org with ESMTP id S264142AbTDOWri 
	(for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Apr 2003 18:47:38 -0400
Message-ID: <3E9C922E.9030108@techsource.com>
Date: Tue, 15 Apr 2003 19:13:50 -0400
From: Timothy Miller <miller@techsource.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Compressed kernel messages from an actual extraction from kernel
 source
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I decided it was time to see if I could compress REAL kernel messages, 
extracted from real kernel source.  There was too much junk in the 
output of 'strings' from the image.  I tried using 2.5.67, but I 
couldn't get it to build.  After finally giving up, I grabbed 2.4.20.  I 
hacked up Rules.make to produce .i files as well as .o files and wrote a 
parser to scan all source files looking for valid printk statements. 
 After dealing with some issues with __FUNCTION__, etc., I was able to 
get a good list of all strings found in a build of 2.4.20 with all 
default parameters (I ran 'make config' and held down Enter).  If 
someone would like to help me build a better list, please email me.

As you'll see, the actual number of kernel messages only come to about 
128280 bytes, which is much less than my previous experiment, but it's 
also, by proportion, more compressible.  That shrinks to 59849 bytes. 
 That's 53% smaller.

My next step after this is to write a filter which locates format 
strings a little more intelligently than the extractor, replaces them 
properly, and readies them for compilation.  I'm going to need perhaps a 
bit more help with the Makefiles.  One thing I tried was making %.o 
depend on %.i, hoping it would use the existing %.i rule, but it didn't. 
 One way to do the filtering is to have .q (or whatever) files depend on 
.i files which depend on .c files, and .o files depend on .q, where .q 
files have the strings replaced.  Oh, and, of course, I have to rewrite 
printk() which I've not even bothered to LOOK at yet.  :)

If you're wondering why I'm expending so much energy on shrinking the 
kernel memory usage by a mere 68431 bytes, it's because I'm a geek, and 
I'm having a blast.  Isn't the open source movement great?  :)  Now, 
it's time to go home to see my wife.  Yes, I have one of those.  :)


Here's the code table.  Codes are in octal.

code shrink count word
200  5160    179  [    OUT_RING( 0X%08X ) AT 0X%X]
201  3602    902  [>[DRM]
202  2224   2227  [ %]
203  1638   1641  [: ]
204  1506    755  [ING]
205  1463   1466  [D ]
206  1399    468  [<7\201:]
                  (<7>[DRM:)
207  1390    175  [] *ERROR*]
210  1264    423  [LOCK]
211  1188     71  [KERNEL\203ASSERTION (]
                  (KERNEL: ASSERTION ()
212  1164   1167  [RE]
213  1107   1110  [T ]
214  1051    352  [    ]
215  1001   1004  [ER]
216   926     33  [ ADVANCE_R\204() WR=0X%06X TAIL=0]
                  ( ADVANCE_RING() WR=0X%06X TAIL=0)
217   851    854  [E ]
220   814    205  [FAILE]
221   772    259  [<6\201]]
                  (<6>[DRM])
222   745     84  []\214OUT_R\204\202X]
                  (]    OUT_RING %X)
223   742    745  [IN]
224   664    334  [<3>]
225   655    658  [S ]
226   650    653  [OR]
227   636     23  [7>\212SET_XMIT_TIM\215 SK=%P\202\205WHEN=0]
                  (7>RESET_XMIT_TIMER SK=%P %D WHEN=0)
230   614    617  [AL]
231   613     42  [\210\203FH NO\213V\215IFIED!]
                  (LOCK: FH NOT VERIFIED!)
232   598     76  [FLOPPY%D\203]
                  (FLOPPY%D: )
233   578     21  [COPY\203COPY\204\202S/%S, \230\212ADY V\215IFIED]
                  (COPY: COPYING %S/%S, ALREADY VERIFIED)
234   577    580  [\202D]
                  ( %D)
235   557    560  [AT]
236   544    547  [ON]
237   520    175  [<3\201:]
                  (<3>[DRM:)
240   510     33  [\221 BEG\223_R\204(\202\205) \223\202S]
                  (<6>[DRM] BEGIN_RING( %D ) IN %S)
241   504     23  [<7>BUG\203UNKNOWN TIM\215 V\230UE]
                  (<7>BUG: UNKNOWN TIMER VALUE)
242   502    253  [<6>]
243   492    248  [0X%]
244   489    492  [DE]
245   478    481  [TE]
246   470     60  [UNABL\217TO ]
                  (UNABLE TO )
247   450    227  [NFS]
250   448    451  [%D]
251   438     21  [<4>FH_\210:\202S/%\225\230\212ADY \210ED!]
                  (<4>FH_LOCK: %S/%S ALREADY LOCKED!)
252   436    439  [%S]
253   423    426  [, ]
254   421    424  [LE]
255   419    422  [\204 ]
                  (ING )
256   416    210  [RPC]
257   409    412  [ST]
260   398    401  [OU]
261   379    382  [SE]
262   376    190  [NO\213]
                  (NOT )
263   352    355  [AN]
264   349    118  [\244VIC]
                  (DEVIC)
265   348     71  [) \220\205A\213]
                  () FAILED AT )
266   346     13  [:\252\207 EXCESS 
F\212ES:\202\205F\212ES,\202\205\230LOCS]
                  (:%S] *ERROR* EXCESS FREES: %D FREES, %D ALLOCS)
267   346    175  [<4>]
270   342     87  [.C(\250)]
                  (.C(%D))
271   329    332  [EN]
272   328     23  [C\230\254\205WITH\260\213\210 HELD]
                  (CALLED WITHOUT LOCK HELD)
273   325    110  [08LX]
274   317    320  [RO]
275   302    305  [] ]
276   298     76  [BUFF\215]
                  (BUFFER)
277   298     21  [\247D\203FH_\210(\252) \210E\205=\234]
                  (NFSD: FH_LOCK(%S) LOCKED = %D)
300   287    290  [:\202]
                  (: %)
301   284     23  [<\227X%LX\253C\230L\215=%P]
                  (<7>RESET_XMIT_TIMER SK=%P %D WHEN=0X%LX, CALLER=%P)
302   284    144  [TO ]
303   266     68  [APIC ]
304   264    267  [ C]
305   258    131  [<7>]
306   250    127  [02X]
307   242    245  [AR]
310   241    244  [TI]
311   238     81  [SCSI]
312   235    238  [AD]
313   235     80  [\230LOC]
                  (ALLOC)
314   228    231  [IS]
315   227    230  [UN]
316   227    230  [\202\205]
                  ( %D )
317   223    226  [CH]
320   223     16  [RTNL\203ASS\215\310\236 \220\205A\213]
                  (RTNL: ASSERTION FAILED AT )
321   222    113  [...]
322   222    113  [PCI]
323   219    222  [US]
324   219     14  [\275BEG\223_LP_R\204(\250) \223\202S]
                  (] BEGIN_LP_RING(%D) IN %S)
325   218     45  [P\274CESS]
                  (PROCESS)
326   206    209  [  ]
327   206    209  [Y ]
330   206      9  [\257\307\213= \243LX\253\271\205= 
\243LX\253OFF\261\213= \243LX]
                  (START = 0X%LX, END = 0X%LX, OFFSET = 0X%LX)
331   202    103  [\210D\203]
                  (LOCKD: )
332   199     68  [\224FH_]
                  (<3>FH_)
333   197    200  [MA]
334   190    193  [=%]
335   190     97  [\215R\226]
                  (ERROR)
336   190     33  [\221\216X%06X]
                  (<6>[DRM] ADVANCE_RING() WR=0X%06X TAIL=0X%06X)
337   188    191  [\202S]
                  ( %S)
340   187    190  [TH]
341   186     48  [SOCKE]
342   184     32  [\224HUB.C\203]
                  (<3>HUB.C: )
343   182    185  [RI]
344   180    183  [P ]
345   179    182  [NO]
346   179    182  [\252\203]
                  (%S: )
347   178     91  [QUE]
350   178     19  [\224\223IT_MODU\254\203]
                  (<3>INIT_MODULE: )
351   178     61  [\256\3004\205]
                  (RPC: %4D )
352   176    179  [\221\200]
                  (<6>[DRM]    OUT_RING( 0X%08X ) AT 0X%X)
353   173    176  [LD]
354   172    175  [AG]
355   172     30  [UHCI.C\203]
                  (UHCI.C: )
356   168     35  [EXT2-F]
357   166    169  [AB]
360   166    169  [NE]
361   165    168  [ME]
362   165    168  [OF]
363   163    166  [ F]
364   163     34  [\223T\215RUP]
                  (INTERRUP)
365   160     82  [IRQ]
366   160     55  [NULL]
367   158    161  [\215 ]
                  (ER )
370   157    160  [\260N]
                  (OUN)
371   154     79  [08X]
372   152    155  [AC]
373   150    153  [AS]
374   150     20  [SYM53C8XX]
375   148     76  [SVC]
376   148    151  [TR]
377   148     31  [\235\245MP\213\302]
                  (ATTEMPT TO )
001   143    146  [ B]
002   142     17  [U.%U.%U.%U]
003   142      9  [\223C\226REC\213\261GM\271\213C\370\213A\213\243P]
                  (INCORRECT SEGMENT COUNT AT 0X%P)
004   142     37  [\223V\230I\205]
                  (INVALID )
005   142     37  [\312D\212SS]
                  (ADDRESS)
006   141     14  [\275\312V\263CE_LP_R\204]
                  (] ADVANCE_LP_RING)
007   139    142  [SI]
010   138     36  [SUPP\226]
                  (SUPPOR)
013   132     68  [C\230L]
                  (CALL)
014   132     68  [\247D\203]
                  (NFSD: )
015   128    131  [IO]
016   128    131  [LO]
017   127    130  [ \212]
                  ( RE)
020   124     64  [TCP]
021   124     10  [\211\257\307\213<= \362F\261T+\254N\265]
                  (KERNEL: ASSERTION (START <= OFFSET+LEN) FAILED AT )
022   122    125  [->]
023   122     63  [\235I\236]
                  (ATION)
024   121    124  [=\250]
                  (=%D)
025   120    123  [ID]
026   118     25  [\314APNP\203]
                  (ISAPNP: )
027   116     60  [BA\205]
                  (BAD )
030   113    116  [E\205]
                  (ED )
031   112    115  [C\236]
                  (CON)
032   112     58  [S\215V]
                  (SERV)
033   112    115  [X ]
034   112    115  [\214 ]
                  (     )
035   112    115  [\257\235]
                  (STAT)
036   111    114  [EX]
037   110    113  [(%]
177   110     29  [\315K\345WN]
                  (UNKNOWN)
141   109    112  [EC]
142   108      6  [\275PI\205=\234\253\264\217= 
\243X\253OP\271_C\370\213=\234]
                  (] PID = %D, DEVICE = 0X%X, OPEN_COUNT = %D)
143   106     55  [MOD]
144   104     54  [<5>]
145   104    107  [MP]
146   104    107  [\226 ]
                  (OR )
147   103     22  [C\260\353N'\213]
                  (COULDN'T )
150   103     22  [\223I\310\230IZ]
                  (INITIALIZ)
151   102    105  [ED]
152   102    105  [_\212]
                  (_RE)
153   102      9  [\207\304\263\345\213C\212\235\217/P\274C/]
                  (] *ERROR* CANNOT CREATE /PROC/)
154   100    103  [CO]
155   100    103  [\207 ]
                  (] *ERROR* )
156   100     35  [\244\245C\245]
                  (DETECTE)
157    99    102  [\202P]
                  ( %P)
160    98    101  [V\215]
                  (VER)
161    98      6  [\346\025\217\031T\274LL\367\236 \322\001\323\202\306 
\244V\202\306]
                  (%S: IDE CONTROLLER ON PCI BUS %02X DEV %02X)
162    96     99  [ P]
163    96     99  [IC]
164    94     17  [ES1371\203]
                  (ES1371: )
165    94     97  [L\217]
                  (LE )
166    94     33  [SWAP]
167    94     49  [\361M\226]
                  (MEMOR)
170    93     96  [PU]
171    92     48  [04X]
172    92     95  [IT]
original size=128280, new size=59849


