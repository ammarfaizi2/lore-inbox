Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261743AbTDOQCh (for <rfc822;willy@w.ods.org>); Tue, 15 Apr 2003 12:02:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261756AbTDOQCh 
	(for <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2003 12:02:37 -0400
Received: from watch.techsource.com ([209.208.48.130]:53985 "EHLO
	techsource.com") by vger.kernel.org with ESMTP id S261743AbTDOQC3 
	(for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Apr 2003 12:02:29 -0400
Message-ID: <3E9C3331.6030700@techsource.com>
Date: Tue, 15 Apr 2003 12:28:33 -0400
From: Timothy Miller <miller@techsource.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Quick report on kernel message compression
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm going to give full details soon enough, but some might be interested 
in where I am so far.  

Below is the current list of codes that are being generated to compress 
my somewhat bogus 'strings' output from a kernel image.  The columns 
aren't all that hard to understand.  The change I most recently made was 
to allow for codes to mix back into the original corpus of text so that 
they could be found in strings generated later in the process.  Doing it 
this way allowed it to compress by 6654 bytes more.  (Certainly, it's 
uncertain as to whether or not the extra complexity in printk is worth 
that 6k.)

I'm probably being much too vague, but I wanted to keep this short for now.

The codes are in octal.  Where they show up in expansion, they are 
formatted \ooo.  The full code expansion is in parentheses.  It's 
interesting to see what some things have gotten compressed to.  Like how 
[G\366\267I\212\307\235] expands to (GIGABIT ETHERNET) but is all 
represented by code \035, or how [\202\327NA\206\234] expands to 
(INTERNATIONAL), which is represented by \155.

The resulting text is 63.5% the size of the original, for a savings of 
84769 bytes.  We'll see what this comes out to when we get properly 
parsed kernel messages to play with.

It's also interested just to get a look at what kinds of messages appear 
frequently in the kernel.


code shrink count word
200  3166   1057  [[^_]]
201  2888    290  [ CONTROLLER]
202  2283   2286  [IN]
203  2041   2044  [ER]
204  1963    656  [UWVS]
205  1771    198  [ TECHNOLOG]
206  1678    561  [TION]
207  1586   1589  [OR]
210  1452   1455  [DE]
211  1433   1436  [RE]
212  1334   1337  [T ]
213  1268    255  [SYSTEM]
214  1197   1200  [E ]
215  1116    560  [PCI]
216  1100   1103  [S ]
217  1072   1075  [D ]
220  1061   1064  [_R]
221  1030   1033  [IC]
222  1025   1028  [: ]
223   994    167  [JOURNAL]
224   973     76  [F 56K DATA/FAX]
225   926    929  [LE]
226   895    898  [CO]
227   888    891  [D$]
230   872    875  [RO]
231   854    215  [BRIDG]
232   832    835  [TE]
233   801    804  [AN]
234   793    796  [AL]
235   781    784  [ET]
236   723    146  [C\207P\207A\206]
                  (CORPORATION)
237   710    713  [AC]
240   706     60  [K\203NEL\222ASS\203\206 (]
                  (KERNEL: ASSERTION ()
241   687    690  [ST]
242   681    684  [AR]
243   650    327  [ \202C]
                  ( INC)
244   646    217  [LOCK]
245   593    596  [EN]
246   591    594  [AT]
247   588    591  [UN]
250   559    562  [ %]
251   544    547  [ON]
252   541    182  [MO\210M]
                  (MODEM)
253   506    509  [AD]
254   504    254  [\202G ]
                  (ING )
255   503    102  [\226MPUT\203]
                  (COMPUTER)
256   499    168  [ LTD]
257   496     84  [E\225CT\230N\221]
                  (ELECTRONIC)
260   492    495  [AG]
261   491    494  [O ]
262   470     60  [) FAI\225\217A\212]
                  () FAILED AT )
263   469    472  [IT]
264   465    468  [AP]
265   461    464  [T$]
266   451    454  [00]
267   451    454  [AB]
270   436    439  [DI]
271   434    437  [CH]
272   434    219  [EXT]
273   424    214  [<3>]
274   423    426  [A ]
275   421    424  [SE]
276   419    422  [TR]
277   414    105  [\211GI\241\203]
                  (REGISTER)
300   402    405  [%S]
301   399    402  [SI]
302   385    388  [\210V]
                  (DEV)
303   384    387  [ []
304   384    387  [ME]
305   364    367  [L$]
306   359    362  [82]
307   349    118  [\235H\203N]
                  (ETHERN)
310   340    343  [AS]
311   339     32  [\224/VO\221E/SPKP ]
                  (F 56K DATA/FAX/VOICE/SPKP )
312   335    338  [Y ]
313   330    333  [BU]
314   329    332  [%D]
315   322     55  [\226MM\247\221A\206]
                  (COMMUNICATION)
316   322     82  [\276\233S\237\206]
                  (TRANSACTION)
317   320    323  [NO]
320   317    320  [ P]
321   308    156  [   ]
322   308    156  [\216\202C]
                  (S INC)
323   307    310  [LU]
324   305    308  [LO]
325   304    154  [<6>]
326   298    301  [MO]
327   294    297  [T\203]
                  (TER)
330   292    295  [ F]
331   291    294  [AM]
332   290    147  [TCP]
333   289    292  [CE]
334   286    289  [ (]
335   285    288  [TI]
336   275    278  [ C]
337   275    278  [ S]
340   271    274  [UP]
341   265    268  [I\210]
                  (IDE)
342   261    264  [LL]
343   259    262  [10]
344   259    262  [X ]
345   253    256  [IP]
346   250    253  [FS]
347   250    127  [\202O\210]
                  (INODE)
350   246     63  [.C(\314)]
                  (.C(%D))
351   245    248  [_\211]
                  (_RE)
352   240    122  [PHT]
353   239    242  [IS]
354   238     16  [ \230A\217R\247N\203\330R\331\214GR\267B\203]
                  ( ROAD RUNNER FRAME GRABBER)
355   238     61  [A\221-78]
                  (AIC-78)
356   236    239  [%0]
357   233    236  [MP]
360   230    233  [MA]
361   228    231  [P\230]
                  (PRO)
362   220    223  [\$]
363   219    222  [12]
364   219    222  [NE]
365   218    111  [,\243.]
                  (, INC.)
366   216    219  [IG]
367   212    215  [->]
370   212    108  [L\202K]
                  (LINK)
371   209    212  [AI]
372   206    209  [16]
373   205    208  [RI]
374   203    206  [ T]
375   202    103  [M\221\230]
                  (MICRO)
376   200    102  [<4>]
377   199     68  [SOCK]
001   198     11  [, R\247N\254E2\346CK I\216\211\226MM\245\210D]
                  (, RUNNING E2FSCK IS RECOMMENDED)
002   198     51  [\2723-\346\222]
                  (EXT3-FS: )
003   198     26  [\275M\221\251DUCT\207]
                  (SEMICONDUCTOR)
004   195    198  [UT]
005   194     99  [QUE]
006   193     66  [\306801]
                  (82801)
007   192     98  [\253\264\327]
                  (ADAPTER)
010   191    194  [55]
011   190     49  [N\235W\207K]
                  (NETWORK)
013   190     97  [\237HE]
                  (ACHE)
014   189    192  [86]
015   189    192  [SS]
016   189    192  [\251 ]
                  (ON )
017   188    191  [FI]
020   188     11  [POW\203EDG\214EXP\233D\267L\214R\371D\201]
                  (POWEREDGE EXPANDABLE RAID CONTROLLER)
021   188     39  [\247\267L\214T\261]
                  (UNABLE TO )
022   187     28  [\337M\242TDAA)]
                  ( SMARTDAA))
023   180     92  [\234\324C]
                  (ALLOC)
024   179    182  [EC]
025   178    181  [V\203]
                  (VER)
026   176    179  [, ]
027   175    178  [M ]
030   169    172  [UL]
031   169    172  [US]
032   168    171  [13]
033   168     86  [\302\221E]
                  (DEVICE)
034   167    170  [_S]
035   166     29  [G\366\267I\212\307\235]
                  (GIGABIT ETHERNET)
036   166     57  [HOS\212]
                  (HOST )
037   166     43  [R\260\214\3638]
                  (RAGE 128)
177   165    168  [1\266]
                  (100)
141   165    168  [64]
142   163     16  [ MIL-\241D-1\0103 ]
                  ( MIL-STD-1553 )
143   163     56  [\313FF\203]
                  (BUFFER)
144   162    165  [20]
145   162    165  [F\207]
                  (FOR)
146   161    164  [_P]
147   161    164  [\215 ]
                  (PCI )
150   160     55  [GMBH]
151   159    162  [A\232]
                  (ATE)
152   159    162  [IO]
153   159    162  [\207P]
                  (ORP)
154   159    162  [\300\222]
                  (%S: )
155   158     33  [\202\327NA\206\234]
                  (INTERNATIONAL)
156   154    157  [\202G]
                  (ING)
157   154     79  [\205IE]
                  ( TECHNOLOGIE)
160   153    156  [\226N]
                  (CON)
161   153    156  [\231E]
                  (BRIDGE)
162   152     23  [HCF 56K ]
163   152     78  [NU\342]
                  (NULL)
164   152     15  [\320\207\212S\203I\234 \253\264T\207]
                  ( PORT SERIAL ADAPTOR)
165   151    154  [P\207]
                  (POR)
166   150    153  [OF]
167   149    152  [DU]
170   149    152  [L ]
171   149    152  [OP]
172   146     75  [<7>]
original size=232629, new size=147860


