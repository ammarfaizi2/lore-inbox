Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751338AbWCNQch@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751338AbWCNQch (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 11:32:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752174AbWCNQch
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 11:32:37 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:56006
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S1751338AbWCNQcg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 11:32:36 -0500
From: Rob Landley <rob@landley.net>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Subject: Re: How do I get the ext3 driver to shut up?
Date: Tue, 14 Mar 2006 10:20:27 -0500
User-Agent: KMail/1.8.3
Cc: linux-kernel@vger.kernel.org
References: <200603132218.39511.rob@landley.net> <20060313193027.b0eae48e.rdunlap@xenotime.net>
In-Reply-To: <20060313193027.b0eae48e.rdunlap@xenotime.net>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_78tFEcyTBpawbUw"
Message-Id: <200603141020.27963.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_78tFEcyTBpawbUw
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Monday 13 March 2006 10:30 pm, Randy.Dunlap wrote:
> On Mon, 13 Mar 2006 22:18:39 -0500 Rob Landley wrote:
> > I'm making a test suite for busybox mount, which does filesystem
> > autodetection the easy way (try all the ones in /etc/filesystems and
> > /proc/filesystems until one of them succeeds).  My test code is creating
> > and mounting vfat and ext2 filesystems.
> >
> > Guess which device driver feels a bit chatty?
> >
> > PASS: mount no proc [GNUFAIL]
> > PASS: mount /proc
> > PASS: mount list1
> > VFS: Can't find ext3 filesystem on dev loop0.
> > PASS: mount vfat image (autodetect type)
> > ext3: No journal on filesystem on loop1
> > PASS: mount ext2 image (autodetect type)
> > PASS: mount remount ext2 image noatime
> > PASS: mount remount ext2 image ro remembers noatime
> > ext3: No journal on filesystem on loop0
> > PASS: umount freed loop device
> > PASS: mount remount nonexistent directory
> > PASS: mount -a no fstab
>
> Hrm, yes, 2 of those lines do come from ext3.

Three, actually.

> Where do the rest of them come from?

My half-finished regression test suite for busybox mount.  I just rewrote the 
busybox "mount" command to fix a half-dozen bugs (the hardest of which was 
making it properly reentrant so "mount -a" behaves properly).  And I 
basically had to derive a spec for mount from first principles (which I've 
halfway written up, should probably finish and post somewhere), and now I'm 
writing The Regression Test Of Doom.

It runs under User Mode Linux, so it has a nice little clean root environment 
to work in and there's no worry about cleanup for when I typo something in 
the script and it crashes halfway through, because when the UML environment 
exits it takes its current mounts with it.  Eventually I'll probably get it 
to run under a normal root environment...

Let's see...  Tarball attached, and I've been running it with:
~/linux-2.6.16-rc5/linux rootfstype=hostfs rw \
init=/home/landley/busybox/busybox/testsuite/mount.testroot \
TESTDIR=/home/landley/busybox/busybox/testsuite COMMAND=./mount quiet

Rob
-- 
Never bet against the cheap plastic solution.

--Boundary-00=_78tFEcyTBpawbUw
Content-Type: application/x-tgz;
  name="mounttests.tgz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="mounttests.tgz"

H4sIAO0/FkQAA+0aa3PbOK5fo1/BUzybuOu3k822V3ebNE6aWSfxxE63O00vpSXK1kUWfaQUx9vm
vx9A6mk7aTtz3b27EcZjiyQIgAAIgJQDJgPXH9fk5Ml3gwbA3u4u/jb3dhvZXzXUbu0+aTZ2Grvt
9l57d+9Jo9na2209IY3vJ1IKoQyoIOSJR33bY4sH8b40/j8Km2TgTmceIwE4AplQ4TMpies7gspA
hFYQCuYShwtyEMrFAb8zNo1N8prPFsIdTwLSajR2yWhBLviI9LSKFEbPtZgvGXElOe73blsVIhkj
vZPX3bNBF+iTYMLICEiO+B0BC4yo5yk2TggPXjQ7YHdBzQBywwkQclyQ02aOCzKSYM4B17cCl/uy
QsxAO7JJQAhi8hn2Ox4dm3o6y2DE08g0VGu+ZUoah3senwMGYf6tK7g/ZX5Abqlw6QgYSxY8B1IA
r89PT/fPDkmHWHw6RX4BJ+yOWWHA1OKHX6QmyZQuyEhRVbN9xUOLTT0YAbFcLoAY6CoRPRLgbffi
4BzUWCV94QJVlN52HYdUQ8Idwqg1IQ4FbdnarBaVrKanHnYPLo9hYlczTBYgqIVhQCMNfj3pA47N
ic8DMmMCDDMFLmADRW9bPcIHpQfjZ9VdTjSwRuEBvWFoR9A4FeMQVSJhTRulZpkcMmkJd6bxOKxH
zjzQ0XzCfCJC30dVRuLijFYZvFAL74FDpPRwcoRnImK7TLp3M2YFoA3BZOiB/MBCBjYPg7JC2QHu
NKBkLtwgYIq98jXT9WdhoFB2V1GAgusnq2V3LprXCxmaIFo66ihYHZykiod+Qf1aSmad65lH+ye9
1+eXZ0MTJvoBdX1JKLHCaejRALUZ8AC8RtMGSn44HTGB7YwbyFqyFWI/y5gGJA0lU64sb9wZsZhA
PnpmhVCPaudLTQ374Ozo5Pj6qLs/vLzoXg/fnJwd/56afw0Ta8Ksm0glaxd63h+eANXe/vHArACh
+cQFXwbZmAuTBGHTWbAg2yCXHkHPRh1Sb04Xklgeo0Iq/y0TtXuYJ1lOZ9zjflWyGRUUPcJzwZ9R
T4xiqJPLtFVgiMQHchkGxNWWVKqYU3BrHvp2BdjitpAoFeiyuYKGW0qhlsEe7G7GRUAS+3YacRey
6KDB3jAPdmAa6wwjVux22fhkxBbpfGTWhBOzlFUh+UzYWLAZMbf/8fl5udTcfv75qlQ2P8K0TXIG
koCov0ADhHxPqn/A9KZJPpDPn+Nmjlo0UPq0qXnekyrsvAb5ABRgjb4RB4+OaapnwUCp2O24RjTS
NO5jN4w3SaJfI+6JVqakKm0qLrt5LnqxQ4xGpSbEcO1Uc/Coccb706CwDWRKT8smeflDSxOALakF
S5YPgbak4iOu9O8pL4xy1bs1yLggc51cONDvHj4H2bKKII2EiMLDdZmlNggF4ugQlR/awSEVhKA/
skgU/CNraH7qe6u0uwUGL8XpqdQy89R2lT9AGILnDBKwoJDnqQfYF93h2/1ep/QLymhNZ4lcEQrg
1m12W/chSycG+mWdG6QuXXpfSho/Nj9k1ITdqY5SvaZLVAMJTZJkuSWx1KjyMdzvGQ79/cEg5qDG
IY9VHa3SFSJrHSG7JnSEH1NHiIxa0krTfn0BVYCQEJK9BRkLOoJyJCoNVIDDkI+VDjqr544EBD6I
OT5jtg69kOggcGAaHvBQWIzMaDCRUA6MXZ0B5xAHSR1+PCwSIJzNXJgJRQBkTNgMiA4hCGPl3JWY
ClTswWQGQZRKCdtBMaKeYNRWJQgia8m4D1K7sFu0aAsgOWO+zXwLpARaVMQcIXSlVdSNNRGcB2rL
6v0KObYF/vnDD3EESB2R1LCBsnZKTXiSE9dRGxHipquKndIrtJbNU6cwS5/c543nzXuTdDrErK9x
jPdoVrOEdOsl19TMMe67fshi50lipIs7QQXGKuyb2tP61kfAj9CmN7YrSHWWkLPNdNCigZ7/Msst
HZ5MuQ0+khlMfZMkqoqGTVLa9mw7FoglEtVrT8lWWWnBZ9qxBuB74QwzmKaQzZ9oO/ScqKiQykvc
2JPOtHclg5jyGBo7KUKwgEIWqv6CVGgn5U3WzjbP2FkrKZjO4Gcn6odeyGsQK7GmmToyP7yKHOs5
N1D/xAKrIheyMhPcqsBYBQLOPYYj0E0vDW9BcnJdoqxy2779TyzuE2x0r1XNKb/U+TZC7NRjH4k6
0DBYF23JV+Anr15tfdQM8AhEwsD13AC3sCP4NKfPNPdknd8EM4IVtSSmkfGIvK5KT/MdsTQRKUPN
9MHV8rrD0BxAgWRBumw8goPhG5CapP0I0h9McIW0m1mxjHwEl6sLYENvipdLFNA8YBsjsyceRlij
gcx4GLmVt+JCYrrqhbBb/upD9f8QKNXWUNeovO/D4/H7n2ar0f5J3//stFvtvdaTRrP9095Ocf/z
Z8Dm3+oj16/DPsMEcDm4bWMUm3kuhR2n9x1GtGgLRsfIL1wAkReCj15FCqv5LHiZXggBKSgoBF4K
kfhWSJUn8dUQBmqbwXHNw/Nqei4ZdgfDw5MLTP1R2tdFL2Y3Eo9uGbqwJ00DMq5lZ+YZRkQoieuq
REjCPmpBLdKoZVILauXEIXMM58zfCkj/5JA0K2REhYPHaV0Al1QB3ATRNpVsmyvngFR9UBH9K3Tx
pMn06R0yayYjmWoyLqFhbGKZCSVlGJ3C47Su7g9WclnNiBM0UYv5NKJyUhHTiicrnl+BGF2ZyYoK
9hWVeiu2XdF2rWDhcU+ujI16KIWebWHihWq7gqa4J3Wpeqc3jqyxu6BVUU+3Dg3u0yT74gXpnh8Z
kU8hfwO0Wc+qUycblV88zmcNMiJ7sNSl7qbqbuLqf2OqPCZ1LAfUxRAn09Ca1Ag5pTeMSDi1o30s
KLS1ll1V2Xuu5QbeopYeKk097HOiSL0/PrvEA8gHk5iklTnXJMeqBZMwBt9XPvziZ5mWEgoGoOJR
NOuZb3AuT5JqJHkdztWgXzNqpBRhiek61LGASrzRU7dHfnRQgB4o39XclfXgKBA3PxO0FBYZ2NIy
gG9FelvMmBZxW8zLGe64l+EkEDB9UAlaxJ3SMUNDRdWZaksoy2Cwhm6DRseHewNKV9fppMUCdzoR
tkJ2p2Mykp3mKYQUkLTTzKnZSHyJVI9IdUSajdYOWZ6ftUtu9sO8lXxfwxsRyfKkLBbeU+CWjf1q
RfcpBbJNw4BD4IITpdJ2Wdt7mXy2jQrOOR64jI5BJGPM7Eklmabsia0tzWZ14EGfTY38BZkTG2Tb
Xydz5OvpdkZHXCajRFXS5H1ySV7BVuT2OcTNKdNcQC8RSiXqXxH4PyRjTP+bZBVKPIY3UvJBwQHp
+8jM18hsxPW0veyNqyMx0YznRziOwKiMUkC6voXk/p18p/FNvvM1C8ibyocT9h2eiOEZ8GArcLHQ
MkS0vuxfD2cPJJNLIBhTjiChq3uciAFdEa5KMU05UJqOMLtQ4PA16Ykg+ST3khckORC+TB9b6XM2
7VrclxzfCMHRsWmsEImHX+abrXzbwPRvROVLVLpIPtVXvXAQ9rhU59+c0pX3kG054aFnx5dqTAgo
BFvlZEroj/DSPOtx6+c00zmwCFtXl1A3ZCamCKsko/dOZbKeeiOljoR9CovbVkPlzOoUz231nV73
J+NVOy+h8gXuONCV4jhke6Ze7jmugBSUkbGcRUqFoFJyy8VMrvgqoo/N5cAASw2GF3+aUDlLEUqA
2D1J5K6hF7j4rhjMpu4toT5RPhoj2CGWXSjCQxiCRS+s9L3m8nAo8R3P8txkH1K58PFuCL7URow3
JN4QwTN+410rPKofXHdFhq4NHeonDbcViOao+8qU37KYgUg5iXmmOVc9PG7CiQjSZqye1WUtCz7y
uHUTe57usiZU5Hu0xyBhlLoc9SYBSQ+hxGVjNRYrGSBg6HJ0ZdgKBRBKXoTDtnat6ChHsEdC9ald
fc7FDWG3LIpPWHzKKd5XR2/qs9W05CIw41ekxKRX/ujKt1Qsgm/dzOdInEE2W5lJjWbjyodiuK1Q
2+pZ9a2ZqG6bdKDL8oLPSLHD5tIUP5wy4aoC3ScxT80u5vI4TwG6EJIhAZEQmHN+c+XPqSdCCL0z
DpsUfuhIwg+lYjxBUhj4oyGNn0eIZ+uckLz2j1+lnuK7kuve+Xl/xZjVw7UThvsH14PLfv/8YvgQ
ubOjAd4GQ6lhM0rmE6peUOr/fTDBahmyl2rGKiHdf73f663KRVcdryrW9Hlr+hydGLUv6rNudEyO
XsCCC2ph8B1MbY0CBrDw64OTY7xp4P7YhcxlTUL/BkObjS/uBauq99ujhSIJ+QdvuudxZkKcjrnT
2mhutDfmeI+onsExNv7gsCfHC4ONx9DT2pjR2QKMZ+wBJiBJHs6MZ8+eQauxQb0xGwlqqM02ABdK
3tncsIVc2j1Q2TDsR/e62ansxB52ZZjL9B7j/ajQJr5qgLVpR8uzB9b454NxlCyi3RIpWgnVqrT9
jFQr1LOsv0k9Oak21X+L8I9AcMhV/+9xA3x/ZnOUVf3XBDWlX+6qa32fzyF0HZ28O+1+06LUXdbY
4yPwnGRvw8KilaabHPqW1/OompcXmF388mK/IHGSZbXIMjaEyFriMeV+k5XywqnKLX1bW1yk/9/D
FDZbDap3xx1/Nx54y//Tzs5D//+EsXZ8/7+3t9PE+//Gbru4//8zIPoP18HJ2dHp8LrbO+osjKjv
zflgeDRI24Pf9vuZ1u+D18Ne2u6eHnQPD7uHaU//4uRs+GvaPrg8ThtHl8Puuwy1N6fd07TZO8jQ
Oej9en3YfXt9ua4Ta6QMmeFh9+LiGlqD81437Yef69dv9s86pmM/b1Tgq2nGY5dnJ++e/XzdH/6e
WWv33bB1fZTvaOc63h7tD3Md/Yvz17kO0FC2OTztZ5tnvQGIddjt7x93r8Hx8yMng/Off959dt2E
7r/aRQoooIACCiiggAIKKKCAAgoooIACCiiggAIKKKCAAgoooIACCiiggAIK+C+GfwMvvqBXAFAA
AA==

--Boundary-00=_78tFEcyTBpawbUw--
