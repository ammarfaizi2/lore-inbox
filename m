Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129267AbQLNSOR>; Thu, 14 Dec 2000 13:14:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129260AbQLNSOH>; Thu, 14 Dec 2000 13:14:07 -0500
Received: from e21.nc.us.ibm.com ([32.97.136.227]:50318 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S129345AbQLNSNz>; Thu, 14 Dec 2000 13:13:55 -0500
Importance: Normal
Subject: inode_cache problem in 2.4.0-test12 ?
To: mingo@elte.hu
Cc: linux-kernel@vger.kernel.org
From: "Bill Hartner" <bhartner@us.ibm.com>
Date: Thu, 14 Dec 2000 12:42:53 -0500
Message-ID: <OF5E9C808A.355D1640-ON852569B5.005D963A@raleigh.ibm.com>
X-MIMETrack: Serialize by Router on D04NM201/04/M/IBM(Release 5.0.3 (Intl)|21 March 2000) at
 12/14/2000 12:43:11 PM
MIME-Version: 1.0
Content-type: multipart/mixed; 
	Boundary="0__=852569B5005D963A8f9e8a93df938690918c852569B5005D963A"
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--0__=852569B5005D963A8f9e8a93df938690918c852569B5005D963A
Content-type: text/plain; charset=us-ascii


Ingo,

I have cleaned up the chat room benchmark and have attached it.

(See attached file: chat.tar.gz)

** I did see what may be a problem with the inode_cache. **

I ran the benchmark on 2.4.0-test12 kernel.
The system was a 4-way 200 Mhz PentiumPro with 256 MB mem.

After about 14 hours of running the client over and over, the inode_cache
starts to grow.  I have included the inode_cache size below.

I started the server with 'chat_s ip_addr'
I run the client over and over 'while (1) { sync ; chat_c ip_addr 10 100 }'
The client and server were running on the same system.

It appears that the inode cache starts to grow at the same rate
that sockets are being created.

Kernel Bug ? Benchmark Bug ? Any Ideas ?

-----

while (1) { cat /proc/slabinfo | grep inode ; sleep 60 }

inode_cache         1148   1458    448  146  162    1 :  124   62
inode_cache         1485   1485    448  165  165    1 :  124   62
inode_cache         1441   1503    448  161  167    1 :  124   62
inode_cache         1441   1503    448  161  167    1 :  124   62
inode_cache         1441   1503    448  161  167    1 :  124   62
...880 more lines...
inode_cache         1477   1539    448  165  171    1 :  124   62
inode_cache         1477   1539    448  165  171    1 :  124   62
inode_cache         1539   1539    448  171  171    1 :  124   62
inode_cache         1477   1539    448  165  171    1 :  124   62
inode_cache         1477   1539    448  165  171    1 :  124   62
...at about 14.8 hours, inode_cache starts to grow...
inode_cache         6129   6129    448  681  681    1 :  124   62
inode_cache        11556  11556    448 1284 1284    1 :  124   62
inode_cache        17568  17568    448 1952 1952    1 :  124   62
inode_cache        23238  23238    448 2582 2582    1 :  124   62
inode_cache        28800  28800    448 3200 3200    1 :  124   62
inode_cache        34110  34110    448 3790 3790    1 :  124   62
inode_cache        40356  40356    448 4484 4484    1 :  124   62
inode_cache        44613  44613    448 4957 4957    1 :  124   62
inode_cache        49752  49752    448 5528 5528    1 :  124   62
inode_cache        56115  56115    448 6235 6235    1 :  124   62
inode_cache        61497  61497    448 6833 6833    1 :  124   62
inode_cache        66721  66969    448 7434 7441    1 :  124   62
inode_cache        72045  72045    448 8005 8005    1 :  124   62
inode_cache        77400  77400    448 8600 8600    1 :  124   62
inode_cache        82902  83088    448 9232 9232    1 :  124   62
inode_cache        88596  88596    448 9844 9844    1 :  124   62
inode_cache        95076  95076    448 10564 10564    1 :  124   62
inode_cache       100854 100854    448 11206 11206    1 :  124   62
inode_cache       107037 107037    448 11893 11893    1 :  124   62
inode_cache       113076 113076    448 12564 12564    1 :  124   62
inode_cache       118836 118836    448 13204 13204    1 :  124   62
inode_cache       124578 124578    448 13842 13842    1 :  124   62
inode_cache       130482 130482    448 14498 14498    1 :  124   62
inode_cache       136179 136179    448 15131 15131    1 :  124   62
inode_cache       142047 142047    448 15783 15783    1 :  124   62
inode_cache       147762 147762    448 16418 16418    1 :  124   62
inode_cache       153274 153522    448 17051 17058    1 :  124   62
inode_cache       159633 159633    448 17737 17737    1 :  124   62
inode_cache       165276 165276    448 18364 18364    1 :  124   62
inode_cache       170388 170388    448 18932 18932    1 :  124   62
inode_cache       175673 175797    448 19526 19533    1 :  124   62
inode_cache       181710 181710    448 20190 20190    1 :  124   62
inode_cache       187299 187299    448 20811 20811    1 :  124   62
inode_cache       192861 192861    448 21429 21429    1 :  124   62
inode_cache       198963 198963    448 22107 22107    1 :  124   62
inode_cache       204912 204912    448 22768 22768    1 :  124   62
inode_cache       210744 210744    448 23416 23416    1 :  124   62
inode_cache       216675 216675    448 24075 24075    1 :  124   62
inode_cache       221931 221931    448 24659 24659    1 :  124   62
inode_cache       227034 227034    448 25226 25226    1 :  124   62
inode_cache       232794 232794    448 25866 25866    1 :  124   62
inode_cache       238653 238653    448 26517 26517    1 :  124   62
inode_cache       244368 244368    448 27152 27152    1 :  124   62
inode_cache       249498 249498    448 27722 27722    1 :  124   62
inode_cache       254493 254493    448 28277 28277    1 :  124   62
inode_cache       259353 259353    448 28817 28817    1 :  124   62
inode_cache       264312 264312    448 29368 29368    1 :  124   62
inode_cache       270387 270387    448 30043 30043    1 :  124   62
inode_cache       275652 275652    448 30628 30628    1 :  124   62
inode_cache       281070 281070    448 31230 31230    1 :  124   62
inode_cache       286398 286398    448 31822 31822    1 :  124   62
inode_cache       291726 291726    448 32414 32414    1 :  124   62
inode_cache       296910 296910    448 32990 32990    1 :  124   62
inode_cache       302373 302373    448 33597 33597    1 :  124   62
inode_cache       307593 307593    448 34177 34177    1 :  124   62
inode_cache       313283 313407    448 34818 34823    1 :  124   62
inode_cache       318288 318474    448 35383 35386    1 :  124   62
inode_cache       323910 323910    448 35990 35990    1 :  124   62
inode_cache       328761 328761    448 36529 36529    1 :  124   62
inode_cache       333027 333027    448 37003 37003    1 :  124   62
inode_cache       337509 337509    448 37501 37501    1 :  124   62
inode_cache       343863 343863    448 38207 38207    1 :  124   62
inode_cache       339879 340065    448 37781 37785    1 :  124   62
inode_cache       345834 345834    448 38426 38426    1 :  124   62
inode_cache       351513 351513    448 39057 39057    1 :  124   62
inode_cache       342063 342063    448 38007 38007    1 :  124   62
inode_cache       347886 347886    448 38654 38654    1 :  124   62
inode_cache       353619 353619    448 39291 39291    1 :  124   62
inode_cache       358479 358479    448 39831 39831    1 :  124   62
inode_cache       363636 363636    448 40404 40404    1 :  124   62
inode_cache       369063 369063    448 41007 41007    1 :  124   62
inode_cache       354258 354258    448 39362 39362    1 :  124   62
inode_cache       360048 360234    448 40021 40026    1 :  124   62
inode_cache       365706 365706    448 40634 40634    1 :  124   62
inode_cache       370656 370656    448 41184 41184    1 :  124   62
inode_cache       351715 353673    448 39278 39297    1 :  124   62
inode_cache       357156 357156    448 39684 39684    1 :  124   62
inode_cache       362664 362664    448 40296 40296    1 :  124   62
inode_cache       367183 367245    448 40804 40805    1 :  124   62
inode_cache       373059 373059    448 41451 41451    1 :  124   62
inode_cache       378819 378819    448 42091 42091    1 :  124   62
inode_cache       329319 336447    448 37377 37383    1 :  124   62
inode_cache       335085 336447    448 37377 37383    1 :  124   62
inode_cache       339822 339822    448 37758 37758    1 :  124   62
inode_cache       345411 345411    448 38379 38379    1 :  124   62
inode_cache       350802 350802    448 38978 38978    1 :  124   62
inode_cache       356634 356634    448 39626 39626    1 :  124   62
inode_cache       361611 361611    448 40179 40179    1 :  124   62
inode_cache       367884 367884    448 40876 40876    1 :  124   62
inode_cache       372411 372411    448 41379 41379    1 :  124   62
inode_cache       377811 377811    448 41979 41979    1 :  124   62
inode_cache       323376 330957    448 36762 36773    1 :  124   62
inode_cache       328584 330957    448 36762 36773    1 :  124   62
inode_cache       333621 333621    448 37069 37069    1 :  124   62
inode_cache       338760 338760    448 37640 37640    1 :  124   62
inode_cache       344268 344268    448 38252 38252    1 :  124   62
inode_cache       349731 349731    448 38859 38859    1 :  124   62
inode_cache       355257 355257    448 39473 39473    1 :  124   62
inode_cache       355446 355446    448 39494 39494    1 :  124   62
inode_cache       355464 355464    448 39496 39496    1 :  124   62
inode_cache       355420 355482    448 39495 39498    1 :  124   62
...

Bill Hartner
IBM Linux Technology Center - kernel performance
bhartner@us.ibm.com
--0__=852569B5005D963A8f9e8a93df938690918c852569B5005D963A
Content-type: application/octet-stream; 
	name="chat.tar.gz"
Content-Disposition: attachment; filename="chat.tar.gz"
Content-transfer-encoding: base64

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


--0__=852569B5005D963A8f9e8a93df938690918c852569B5005D963A--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
