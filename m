Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262940AbTKJGBq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Nov 2003 01:01:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262941AbTKJGBp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Nov 2003 01:01:45 -0500
Received: from viefep12-int.chello.at ([213.46.255.25]:21283 "EHLO
	viefep12-int.chello.at") by vger.kernel.org with ESMTP
	id S262940AbTKJGBi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Nov 2003 01:01:38 -0500
Date: Mon, 10 Nov 2003 07:01:30 +0100 (CET)
From: Peter Gantner <peter.gantner@stud.uni-graz.at>
X-X-Sender: nephros@scourge.crownest.net
To: Tony Lindgren <tony@atomide.com>
cc: linux-kernel@vger.kernel.org, pasi.savolainen@hut.fi,
       Charles Lepple <clepple@ghz.cc>, f.maibaum@web.de
Subject: Re: [PATCH] amd76x_pm on 2.6.0-test9 more cleanup and clock skew
 test
In-Reply-To: <20031110003305.GA2833@atomide.com>
Message-ID: <Pine.LNX.4.58.0311100628440.12413@scourge.crownest.net>
References: <20031110003305.GA2833@atomide.com>
X-Iron-Prison: The Empire never ended.
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Tony Lindgren from Nov 9

> On the clock skew problem, it's still there, and to figure out how bad the
> problem is, I've done a little shell script based on the earlier thread on
> adjtimex on this mailing list.

Here are my results from your script.

Tested two kernels, vanilla -test9 and test-9-love2, the latter is a 
patchset based off -mm2, including the nick scheduler and 
other stuff like reiser4 and bootsplash. More information about this 
here: http://bssteph.irtonline.org/linux/patches/2.6/2.6.0-test9/2.6.0-test9-love2/2.6.0-test9-love2_notes.txt
(amd76x_pm-031027 patch backed out, new one put in )

I did three runs each, first run idle, two runs under load, i.e. two
burnK7 processes and a make -j5 kernel compile just to make sure.
loadavg goes up to ~6.5 during those.
ntpd was not running during the tests.

System is an A7M266-d w/ two AthlonXPs 1800+ (model 6 stepping 2),
L5-modded(!) for the MP setup. (I know this is considered tainting,
if you can tell me the timing issues are related to the modding I
will shut up immediately, but so far nobody seems to have pinpointed 
it to this.)
The two CPUs show different bogomips (3014, 3063).


-------------------------------------------------
test9-love2:
-------------------------------------------------
idle:
-------------------------------------------------
Running test for kernel version 2.6.0-test9-love2
This test will take about 140 seconds to run

ACPI interrupts before the first test: 
  9:          0          0   IO-APIC-level  acpi

Running test without amd76x_pm module
                                           --- current ---    -- suggested --
cmos time     system-cmos       2nd diff    tick      freq     tick      freq
1068439150       -0.014522      -0.014522   10000         0
1068439160       -0.015270      -0.000748   10000         0
1068439170       -0.016013      -0.000743   10000         0    10000   4869626
1068439180       -0.016753      -0.000740   10000         0    10000   4850095
1068439190       -0.017498      -0.000744   10000         0    10000   4876657
1068439200       -0.008564       0.008934   10000   4876657     9992  -1243667
1068439210       -0.008547       0.000017   10000   4876657    10000   4765814
1068439220       -0.008529       0.000018   10000   4876657    10000   4758783

ACPI interrupts after the first test: 
  9:          0          0   IO-APIC-level  acpi

Running test with amd76x_pm module
                                           --- current ---    -- suggested --
cmos time     system-cmos       2nd diff    tick      freq     tick      freq
1068439230        0.009470       0.009470   10000         0
1068439240        0.008725      -0.000745   10000         0
1068439250        0.008987       0.000262   10000         0    10000  -1716312
1068439260        0.009249       0.000262   10000         0    10000  -1716311
1068439270        0.008507      -0.000742   10000         0    10000   4863376
1068439280        0.017441       0.008934   10000   4863375     9992  -1256949
1068439290        0.017461       0.000020   10000   4863375    10000   4732220
1068439300        0.017482       0.000021   10000   4863375    10000   4726751

ACPI interrupts after the second test: 
  9:          0          0   IO-APIC-level  acpi

-------------------------------------------------
load - run 1
-------------------------------------------------

Running test for kernel version 2.6.0-test9-love2
This test will take about 140 seconds to run

ACPI interrupts before the first test: 
  9:          0          0   IO-APIC-level  acpi

Running test without amd76x_pm module
                                           --- current ---    -- suggested --
cmos time     system-cmos       2nd diff    tick      freq     tick      freq
1068439375        0.035483       0.035483   10000         0
1068439385        0.034744      -0.000739   10000         0
1068439395        0.034002      -0.000742   10000         0    10000   4863376
1068439405        0.033272      -0.000730   10000         0    10000   4784470
1068439440        0.030695      -0.002577   10000         0    10003  -2773359
1068439450        0.041556       0.010861   10003  -2773359     9992  -1861789
1068439464        0.044119       0.002563   10003  -2773359    10000     92261
1068439475        0.046135       0.002016   10003  -2773359    10001  -2875039

ACPI interrupts after the first test: 
  9:          0          0   IO-APIC-level  acpi

Running test with amd76x_pm module
                                           --- current ---    -- suggested --
cmos time     system-cmos       2nd diff    tick      freq     tick      freq
1068439488        0.063667       0.063667   10000         0
1068439498        0.062917      -0.000750   10000         0
1068439509        0.062106      -0.000810   10000         0    10000   5310651
1068439519        0.061371      -0.000735   10000         0    10000   4818064
1068439533        0.060339      -0.001032   10000         0    10001    211376
1068439548        0.069771       0.009432   10001    211376     9992  -2622097
1068439560        0.070127       0.000356   10001    211376    10001  -2123667
1068439571        0.070456       0.000329   10001    211376    10001  -1942035

ACPI interrupts after the second test: 
  9:          0          0   IO-APIC-level  acpi
-------------------------------------------------
load - run 2
-------------------------------------------------
 
Running test for kernel version 2.6.0-test9-love2
This test will take about 140 seconds to run

ACPI interrupts before the first test: 
  9:          0          0   IO-APIC-level  acpi

Running test without amd76x_pm module
                                           --- current ---    -- suggested --
cmos time     system-cmos       2nd diff    tick      freq     tick      freq
1068439753        0.103258       0.103258   10000         0
1068439763        0.102513      -0.000745   10000         0
1068439777        0.101485      -0.001028   10000         0    10001    185595
1068439787        0.100754      -0.000731   10000         0    10000   4790720
1068439799        0.099872      -0.000882   10000         0    10000   5779020
1068439809        0.108959       0.009087   10000   5779019     9992  -1344430
1068439819        0.109129       0.000170   10000   5779019    10000   4665051
1068439829        0.109299       0.000170   10000   5779019    10000   4665833

ACPI interrupts after the first test: 
  9:          0          0   IO-APIC-level  acpi

Running test with amd76x_pm module
                                           --- current ---    -- suggested --
cmos time     system-cmos       2nd diff    tick      freq     tick      freq
1068439843        0.127032       0.127032   10000         0
1068439854        0.126197      -0.000835   10000         0
1068439867        0.218674       0.092477   10000         0     9908  -3126099
1068439882        0.124147      -0.094527   10000         0    10095  -3102405
1068439898        0.122977      -0.001170   10000         0    10001   1113739
1068439909        0.132439       0.009462   10001   1113738     9992  -1911961
1068439924        0.133104       0.000665   10001   1113738    10001  -3246667
1068439935        0.133593       0.000489   10001   1113738    10001  -2088111

ACPI interrupts after the second test: 
  9:          0          0   IO-APIC-level  acpi
-------------------------------------------------
vanilla 
-------------------------------------------------
idle
-------------------------------------------------
Running test for kernel version 2.6.0-test9
This test will take about 140 seconds to run

ACPI interrupts before the first test: 
  9:          0          0   IO-APIC-level  acpi

Running test without amd76x_pm module
                                           --- current ---    -- suggested --
cmos time     system-cmos       2nd diff    tick      freq     tick      freq
1068441482       -0.004717      -0.004717   10000         0
1068441492       -0.005453      -0.000736   10000         0
1068441502       -0.006187      -0.000734   10000         0    10000   4810251
1068441512       -0.006916      -0.000729   10000         0    10000   4778220
1068441522       -0.007656      -0.000740   10000         0    10000   4850095
1068441532       -0.007642       0.000014   10000   4850094    10000   4758782
1068441542       -0.007617       0.000025   10000   4850094    10000   4686907
1068441552       -0.007595       0.000022   10000   4850094    10000   4706439

ACPI interrupts after the first test: 
  9:          0          0   IO-APIC-level  acpi

Running test with amd76x_pm module
                                           --- current ---    -- suggested --
cmos time     system-cmos       2nd diff    tick      freq     tick      freq
1068441562       -0.007592      -0.007592   10000         0
1068441572       -0.007321       0.000271   10000         0
1068441582       -0.008068      -0.000747   10000         0    10000   4895407
1068441592       -0.008798      -0.000730   10000         0    10000   4785251
1068441602       -0.009534      -0.000736   10000         0    10000   4823532
1068441612       -0.009595      -0.000061   10000   4823532    10000   5223627
1068441622       -0.008579       0.001016   10000   4823532    10000  -1834186
1068441632       -0.007561       0.001018   10000   4823532    10000  -1847467

ACPI interrupts after the second test: 
  9:          0          0   IO-APIC-level  acpi
-------------------------------------------------
load - run 1
-------------------------------------------------
Running test for kernel version 2.6.0-test9
This test will take about 140 seconds to run

ACPI interrupts before the first test: 
  9:          0          0   IO-APIC-level  acpi

Running test without amd76x_pm module
                                           --- current ---    -- suggested --
cmos time     system-cmos       2nd diff    tick      freq     tick      freq
1068441806       -0.023066      -0.023066   10000         0
1068441817       -0.023886      -0.000820   10000         0
1068441827       -0.024622      -0.000736   10000         0    10000   4824313
1068441838       -0.025433      -0.000810   10000         0    10000   5310651
1068441856       -0.026762      -0.001330   10000         0    10001   2159852
1068441868       -0.026087       0.000675   10001   2159851    10001  -2265817
1068441881       -0.025307       0.000780   10001   2159851    10001  -2952136
1068441892       -0.024650       0.000657   10001   2159851    10001  -2142779

ACPI interrupts after the first test: 
  9:          0          0   IO-APIC-level  acpi

Running test with amd76x_pm module
                                           --- current ---    -- suggested --
cmos time     system-cmos       2nd diff    tick      freq     tick      freq
1068441902       -0.024727      -0.024727   10000         0
1068441913       -0.025560      -0.000832   10000         0
1068441927       -0.026594      -0.001034   10000         0    10001    224658
1068441940       -0.027553      -0.000959   10000         0    10000   6284889
1068441950       -0.028289      -0.000736   10000         0    10000   4824313
1068441960       -0.028363      -0.000074   10000   4824313    10000   5309564
1068441971       -0.028348       0.000016   10000   4824313    10000   4722464
1068441982       -0.028328       0.000020   10000   4824313    10000   4695902

ACPI interrupts after the second test: 
  9:          0          0   IO-APIC-level  acpi
-------------------------------------------------
load - run 2
-------------------------------------------------
Running test for kernel version 2.6.0-test9
This test will take about 140 seconds to run

ACPI interrupts before the first test: 
  9:          0          0   IO-APIC-level  acpi

Running test without amd76x_pm module
                                           --- current ---    -- suggested --
cmos time     system-cmos       2nd diff    tick      freq     tick      freq
1068442024       -0.028550      -0.028550   10000         0
1068442034       -0.029312      -0.000762   10000         0
1068442044       -0.030048      -0.000736   10000         0    10000   4823532
1068442060       -0.031229      -0.001181   10000         0    10001   1185614
1068442075       -0.032338      -0.001109   10000         0    10001    711776
1068442085       -0.031986       0.000352   10001    711776    10001  -1594379
1068442095       -0.031610       0.000376   10001    711776    10001  -1751411
1068442112       -0.030975       0.000635   10001    711776    10001  -3448610

ACPI interrupts after the first test: 
  9:          0          0   IO-APIC-level  acpi

Running test with amd76x_pm module
                                           --- current ---    -- suggested --
cmos time     system-cmos       2nd diff    tick      freq     tick      freq
1068442127       -0.031614      -0.031614   10000         0
1068442141       -0.032668      -0.001054   10000         0
1068442159       -0.033992      -0.001324   10000         0    10001   2126258
1068442169       -0.034728      -0.000735   10000         0    10000   4818063
1068442181       -0.035613      -0.000886   10000         0    10000   5804020
1068442191       -0.035545       0.000068   10000   5804019    10000   5358801
1068442203       -0.035345       0.000200   10000   5804019    10000   4491633
1068442217       -0.035103       0.000242   10000   5804019    10000   4219777

ACPI interrupts after the second test: 
  9:          0          0   IO-APIC-level  acpi
-------------------------------------------------

Hope this helps a bit, and thanks for cc-ing me
	Peter G.

-- 
I object to intellect without discipline;  I object to power without
constructive purpose.
                -- Spock, "The Squire of Gothos", stardate 2124.5

