Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285540AbRLNWUj>; Fri, 14 Dec 2001 17:20:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285553AbRLNWUb>; Fri, 14 Dec 2001 17:20:31 -0500
Received: from mail.cogenit.fr ([195.68.53.173]:54158 "EHLO cogenit.fr")
	by vger.kernel.org with ESMTP id <S285540AbRLNWUX>;
	Fri, 14 Dec 2001 17:20:23 -0500
Date: Fri, 14 Dec 2001 23:19:32 +0100
From: Francois Romieu <romieu@cogenit.fr>
To: linux-kernel@vger.kernel.org
Subject: freeze (2.4.17-pre/rc + Promise 20265)
Message-ID: <20011214231932.A2949@se1.cogenit.fr>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="vtzGhvizbBRQ85DL"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Organisation: Marie's fan club - II
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--vtzGhvizbBRQ85DL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

As soon as a disk is present in the first slot of the Promise adapter the 
kernel locks during boot as shown below (no sysrq, no led, nothing)
[...]
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller on PCI bus 00 dev 39
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100 controller on pci00:07.1
    ide0: BM-DMA at 0xb000-0xb007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xb008-0xb00f, BIOS settings: hdc:DMA, hdd:pio
PDC20265: IDE controller on PCI bus 00 dev 60
PDC20265: chipset revision 2
ide: Found promise 20265 in RAID mode.
PDC20265: not 100% native mode: will probe irqs later
PDC20265: (U)DMA Burst Bit ENABLED Primary MASTER Mode Secondary MASTER Mode.
    ide2: BM-DMA at 0xdc00-0xdc07, BIOS settings: hde:pio, hdf:pio
    ide3: BM-DMA at 0xdc08-0xdc0f, BIOS settings: hdg:pio, hdh:pio <- appears
[insert guru meditation here]

It's 100% reproductible with 2.4.17-pre8/-rc1 and RedHat's 2.4.7-10.
The disks are all the sames. Swapping them doesn't change anything.
Tried RH 2.96-98 as well as egcs-1.1.2 -> lock.
Disabled APM, ACPI, SMP (APIC+IOAPIC enabled) -> lock.

/proc/pci and /proc/cpuinfo follow.
Attached is a "normal" complete boot dmesg (I simply removed the disk).

If it isn't the expected behavior before refund, I'm open to
suggestions.

Thanks.

$ cat /proc/pci

PCI devices found:
  Bus  0, device   0, function  0:
    Host bridge: VIA Technologies, Inc. VT82C693A/694x [Apollo PRO133x] (rev 196).
      Prefetchable 32 bit memory at 0xd0000000 [0xd3ffffff].
  Bus  0, device   1, function  0:
    PCI bridge: VIA Technologies, Inc. VT82C598/694x [Apollo MVP3/Pro133x AGP] (rev 0).
      Master Capable.  No bursts.  Min Gnt=12.
  Bus  0, device   7, function  0:
    ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 64).
  Bus  0, device   7, function  1:
    IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 6).
      Master Capable.  Latency=32.  
      I/O at 0xb000 [0xb00f].
  Bus  0, device   7, function  2:
    USB Controller: VIA Technologies, Inc. UHCI USB (rev 26).
      IRQ 5.
      Master Capable.  Latency=32.  
      I/O at 0xb400 [0xb41f].
  Bus  0, device   7, function  3:
    USB Controller: VIA Technologies, Inc. UHCI USB (#2) (rev 26).
      IRQ 5.
      Master Capable.  Latency=32.  
      I/O at 0xb800 [0xb81f].
  Bus  0, device   7, function  4:
    Host bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 64).
      IRQ 9.
  Bus  0, device  12, function  0:
    RAID bus controller: Promise Technology, Inc. 20265 (rev 2).
      IRQ 11.
      Master Capable.  Latency=32.  
      I/O at 0xcc00 [0xcc07].
      I/O at 0xd000 [0xd003].
      I/O at 0xd400 [0xd407].
      I/O at 0xd800 [0xd803].
      I/O at 0xdc00 [0xdc3f].
      Non-prefetchable 32 bit memory at 0xd8000000 [0xd801ffff].
  Bus  0, device  14, function  0:
    Ethernet controller: 3Com Corporation 3c905C-TX [Fast Etherlink] (rev 120).
      IRQ 10.
      Master Capable.  Latency=32.  Min Gnt=10.Max Lat=10.
      I/O at 0xe000 [0xe07f].
      Non-prefetchable 32 bit memory at 0xd8020000 [0xd802007f].
  Bus  1, device   0, function  0:
    VGA compatible controller: ATI Technologies Inc Rage XL AGP (rev 39).
      IRQ 10.
      Master Capable.  Latency=32.  Min Gnt=8.
      Non-prefetchable 32 bit memory at 0xd4000000 [0xd4ffffff].
      I/O at 0xa000 [0xa0ff].
      Non-prefetchable 32 bit memory at 0xd6000000 [0xd6000fff].

$ cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 8
model name      : Pentium III (Coppermine)
stepping        : 10
cpu MHz         : 1002.287
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr sse
bogomips        : 1998.84

-- 
Ueimor

--vtzGhvizbBRQ85DL
Content-Type: application/octet-stream
Content-Disposition: attachment; filename="dmesg.gz"
Content-Transfer-Encoding: base64

H4sICAd4GjwAA2RtZXNnAOxbe3PjRo7/n58Cu9m7yHUSzSYlSuLFqZUlzQx3rLHO8nizlUq5
KJKSuJZIhQ8/8unvh26SkvwY29mtq9urc00oshtAA2gADYDMWRQX93QbplmUxGTqbV10W6kv
WgY10iTJ/5yFnSNqLH2/BgqXftYy9b7QbZtEv983LNE+PpOEGnJS6EI3KQ3XoZeFR0f0nbDp
QxrRKPRJtMkUjtl1zA4Nx5dkGobQTt3zWWubJrdREAa0XT1kke+t6WIwoY23dTSSAGHPNBwy
Hv1Ra3+ov/Ax1Cgyb74Oj15CVFAHiJ6k1UjDLExvw+BF1MWTNYXxNlTxmF2xWChq32S3hjpE
tCTiYDh16cvV7GVU6xDVrLSmUAMv957HXYT+I35FrfE9URdJEQc0m0xpMm3lLAV5OWMsOn7X
0FabJm29ZahGGLdCpfwu8kP9EMJ+FUK8CmE+B3EeU5wEAKA8yb01A2cOCUsYHVv7LYnDhnHk
UNvo25JQpqtBgUFh2n3bOBg2MVyPuHEermlSrPNomiZ+mGVJSrNt6EcLGHHOHnMLh9AIf1dR
mhcw7L9GaUh+stlifh6to/yBNmAPfI4n5I4cwq9SNUgGhZ/LwenF+ajeg8HUHULVYOT+w3gs
x7Td+t8BM4zzqNg08s0RU1EIlQ+LruYen6ux70y6qofl7oHiUFLUdyRZXdrnMI0hLDjfeNj2
dRSHDp2en19eu5PBx/HJQfzAmhxBTvqGUDAf3LPxyfEcY8fz39wN1Nd6hADo4yC8Pd4EglaB
d9Jtd+2m2ek0bQvP/sEzQoVx4hXYzyIO+UkcPJkHT9buKd5E13de7q+CZHkiNExeZ2FebJ3H
Kx5O+S9NHfDxaEK8NGG+NLFjFIYV5ZG3jn6L4iUNp1+/M7RRmId+DrOGG5i62evS5NNvtK32
SNeGSZwla2yKn6yTIqWrj4P/oJ5xb3a0IUjNUxgcqAXh2nugdZJsdV3nGN7Te206TZbJxJ3O
tEm4SdIHhzoCS5g3xx2zbZrtG/JuvWgtfbwhTNO4oZvKHoKwCZ76NoAq12tSv9e/kRGmSSbP
RBCoSUBbRcvVJtwcaTfBfGeSep/mDzTzkzynsyKNA2/dpM9hlK/o/C6MM52GyfYhBW5Os49u
kwZrHBH8mNFFuSg0FOfpQ8v3/FVIKy9bkQpKPByxz9udjmVTI0mDMHWo2yQWrtfD0nmYHUHp
kOUb6JbZtXs1us2SmaLdrtAnCIf5N9B7om/W2O1myU2JfFosFmH65sU7TRnAumaFP2WPehm7
BH5RdJgYnDlcJIhNt2EcIIyoHfO9LdANq9ddzBeL+oSob5oV+AkZisqZIJckJ1jW/tzkgdHe
QAllVkNmpxobLPIwfd/y9Q1TINgBnIbiYjMHoSCSJ2tQhekN1kPQIqzqw55TPLFHFRA5K7bb
JM1fgk1DnmXnCWNJkmCz0it1xTn/Ke6XYQwm/D3OrTdwrihUf0OEWCzwTgqK8TLyk+u61IDP
bMN0A0GOKMvD7ZZFMDxtzFLw/cLLcvrAmvNucXgjrMODcxgBh4YAx52+gy3ijZfdQPaZOxlJ
pPDeD7fykCv1t8Mast4Y6/vVOv8em5nlKY4ywDLM+WccLucz9ydEjxg2hwPFDwmGKHWMQPD1
i/vB/UmrtD2+z90vl7XStfHsgm69dRHSXJlsWDF5iw1N0jqTae+BenJ/XoIE0S+D0zP3y0dy
z1vybHQv/ivTZmEumTIhA+XwLk5Qr6PgesuxLs6vkaNqkMlfefGSASvsOpFVtEZIPkCEpU9u
dI2tG6DXu4VqxIa3jfwoaGGzjshswcPMlrDltSuvPXnt89WUs6aQV1NeLSQ7Oes1lqeFDuYu
3cn4wiklPjHuLUEgLk5M/jFPDM3Dztyq0+HLxKW/lick7faz2huevtuflhviyHEPxualGQs6
h0vlhX/zB630xWSBHJEFpQxHky9Dkq3vzVbSf8e1wzKCtXLWYbZ3S7PyXZW26M//aZpbpzXl
CF9qgsiMOMkt02CtxGKPcx5tVxQw3BNsweYiuj1DiH1soG+8ewAGSO2kke8CL8M/gp1CC9Fm
uw43gAoDzq0OASopytNREhFPmDH3bPcQ30vnUZ7K9JNhFCbrfp9DeUCguvpyQWfYy+nqgSbw
b7rEIQvgC5oma5rlSAlH2ABc1hFSRT/nUKWRij78Q4IXNaqLsf9QXgzACxaCfx7N1vCivlh9
wJvvgEd+bVhvh28zfPsd8MxPp4bfTRjlzSP4DtO3306/w/S7b4e3mX7vHfBMv/92+C7T994u
b5fpz98O32P6/tv56TH94O3wfaYfvgOe6S/eDj8AffFO+xfinfDmO+Gtd8K33wnfeSe8/U74
7rvgOZjhmMHxxT0iTmsyhwcNav1IhmPyvVD3gu8tdW/xfVvdt/m+o+47fG+re5vvu+q+y/c9
dd/j+76670v65WJCsiOq5eR62D71pDgplxdyfVEyICQHomRBdKog/s2/8jj+mvGJuE7qAyuP
NiHnzDga0mKbZ7rm75V8eyDVoShPbvJB4oaybYgkK8rKyhJFDZeWFdwqQfifF9kTYMvSbavd
U7D+tsBZ01RAsuCweLJJ2TrykeXbdk9025ypGj9csiowbdnNS+HwjG00R47ZnDkKrDl0Svwf
tU2eIku7FXrboAY3DA1UQkeo/ZBxpQF9TBJ/RY10yb9/9vJ4oftZlCa6VxyVuEFVOPMj5Q/b
sEyWtenQxXE8dGUPDKfjbVR2QrG3spZUHZHF3PQh2tpTijgRClFtAmew0bJQx62kTuX8NE3m
DMELMK93XhpqX+ObOLmLaZ5GwTLkdFvmQ4TT3MuyYiMzndSLsy2g43x/JXmCJwWf/lfugH4W
wrCPDbtn/6Labo7R1Q2FUCftV5GHNB0ocWUpTAEzmurZfhlftnWDkESTGjD1tnbqZdBWsYU8
szuwEnr0NY5kNpI/cHWylUzMEj8KMQAalm7g1D5oWlxcUhzmYAImA5MIcw3JhCqibrI7bxto
Vx9mDo2i7ObXIsm9rG4GBPx8bevMWFSRRHn/F2gKYnBBcCpNcYQNg+qClHmDN3gBoG6XnrAX
c2eHytLWoxwuuDWYYF/9svO765xkd1HOhd+SAco2yiL1Nig0ZH0OW5JL9pBEG9pijnTy6uMA
wQ7X5wC1bf4gK1xW4H2/R3jOapMBtzNVsZYiVBro6EbHV9beMroto3dEd9wK+fT1tGXTZPDl
b9fT84vLGU2+nl26fEuzT4OL8TWbyGx84Q7OrtnqyvpJy/OHGUKrNGbDWvSoEaW/omJvH7Ej
e4jWnY4xUGCiBDN3YNYh2EUIji8RTWiotqFkXsBtQm3OY9w57cH1kzwjVKD0axEWYZPmXDmc
WKZ2MZiM3NnnSu69Xea6QPb+Ub3fZFwZcGP2M2WYRHwy2yQX4Ef4UsTFo+q/tqZrL5eP45Y7
GlekL0qnRgTSLdnxc2hQOZplcQste0BGvZEhTgU39oYpknBuy2b/SQnowFtDtQe44Rhwf69d
Ta+xEGIJVsOW5mkC20y5SmXdMznoHHbACW0FC+PaZmG+izV2PcVlGwLwv1GMUIJqnFd3sOZ6
zU0+VFTYjAxBCK5X43AcuM17po8oMOfW/C3UdSQ5+jqaDEDuEWdbP1KBQvWkuX/p0OmkBWC1
73P4Q0v+oNiUYTFTFXAme6QOAJu4mfNNRUI8IdFTJBbPkPArEoGzjRJtOhqahml33qBG29iD
fqJIU+3tB/lOAgrbRBmiKgNz5X4xQAWu2uw7Gu/R+A6r8fWIRT0tUhwHpyjjZeNgPEK8jzYe
zozJYHY5vqAJv3OYhRApeDSqV4ozDxUX+FL3+HlO9yHrixW3kIorSVhPSPQUied0v6xIrCQJ
3k9yh1bnzLCNwdX4gmNNkwaXA9p5p8abTWcfaThqXZxPaHgxavU6pnkqAacuxo9HV2quQvDf
RHb5Big2UCWZWLBuxKLbROxd2GwfHJ2QRbEFljBdCdOVMN0dTIdhrFJDbaXktsFQQQ+VZgUm
lEaEKZMMWF0mOyYZNWzR7ls0OUUcPhZ9YX+OTmnI7csmDT/N5NuBY7PTObatpnS8hmUdKT38
84gtfw8xgbGOcSzsHTVYPLeLcRTLjEV2OB1NOjdf5MsXU5Oeyhd+9uXz0vmh++PZaOIQjcan
Xz9SYx1sdL9JfZtfit0igAfwlettRfta9RjoS0KTWWsEY6ynSL47hCMUZT60m5FIGicm8GZ5
pI44knPGYehtWxumSfxwT2d50KTZQ+yv8JwgSkynU9nBHLqz4Tl9Gp0NqeEf8QuOdpnscIuy
GuvBgaN1IHtaqgl1uUrDkMnSv9NfvJj++LcwfvD+SJ+9bJv+5t3o2mw4cykr5uWB8eSEETpy
iTTEYZfl1wgmxTr8OUM2es0ptBd4W8jwi0MXCeLOIpPhZ8PvDHBCb3DwpV4UCD4uswRpDqda
VbcHZxLyozglSwJugmptQ+8byJImg5+uJ6Pr0fhqdoJko0l4mJ1esx9hoCuRBkWeqExYZmcc
D7009R5QKtDP4S1yzaxqKHX6v/xDY7wcv8lKi1jWG/yMMJjBCVNenA2qniAvCL4x6O0G/TT0
ZBofCPmM5Dr4gSGa4sf9Ad9smmoADMQg45Ac/VECqxl+/j4jyTt4401IdyKUIN5rIFKLa0Cs
UbUGSaj2NOYcwl/BsjlL+QMS5hg6L1geL3648x5YHKF6hvKNNPYZ1rHCBYdPHCR3HLQ5AxVm
+0bBCvkurSWTombZbaxwOMGqZx2FJG3JqdJVqdsEcLJIwYKwpk2UpshzxBNQ7yVQowLlH8ki
v6qVveMyNwJmkXPOZpY4mVRTsQ1UHcrwUmdZgRVkIsfBt8yVq315YlLeLz/YPzbu0igPj6qd
y+ZYZwEmkF4Lo91u9+pNew3f+wb+IzMVz5npc4OeeMZMjQMzFY/NVDxrpkKaqajNVLxupq+B
/ANmarzDTI1/gpmKt5vpS6DPmanxTjM1XjdT8aqZikMzE0bHFLZRb9qrZvoNfO7LVBF2dP5l
rGvueDxGWWrqJp3h5Nsv6EV15tlctdFgvfVwnGblEaugLofTY3fKJ5hEVW0BDSPTNMkTVMIZ
J2uTKecQuAC8Se7HyRQgTtVSoCevn8vqDUk8NwBgEZb5Wb5w1kDAoU815H5NTA0cn9y+yFZ4
UK+92WXU7VF5loO1DZd9Pjdlyq4IjkKbtmvOBdxJazYpJeTSG2a/8VAHqFZExoIe84dLOz0p
kXXt5u+qzQDTKfsVunoji0xf9teQ51CHEzAk9pk2/unSai2gnfIkp0UEcVSCII1NvnHHOJt+
WYHIxsekhOcPXyDyfW7toR5Jv0niNZzwA9IS9f614LZM+dnFpvxMQ35csQBIoA1UMJrdedvS
WjrmDXGvpZVtPThNY5tGScqJRUscaUU215Hi7eUYcXhXJRaYhLkvsm9DrYo5A7SKlR8x1J/2
cyET+/Yn2XXkj/6svtOx6o8A+bu/fcRP0XJFc2Rvd1EAnbGa6ubFPtzX2Sl9/YSyEKk8f8OE
KrPN3yBw36NzAFl/LWPKtK8WhLlnKlxX7oRqcvMtWsaA54nytaSokG423hpRgNwPFCzmgbcQ
7SYDRYsdjFSLCk5ZnqqKa7JIT8Bd+R3XiYmEVfZ7VMZ5UuMyQyVutTSeFx4MHOVnvCz4+zbE
I+NefufFxPZ0IfPJT9iKfeI4ZqAZDTtULYBblXVXg6Vm6v5oNQ675+9vkjiUG1yOLsEHf5+Z
3IG9uk9Wz66TOfyCWyUtv0i5dck1dK5eNlZQU07A4cr8bRxXL14ayqOo/vyiAlSrcDGQlPfL
JAmkMYHvTVbBsUx7PYNqZc7Bo1S+X0V03Qx2ZFOe3CS3MjxB0LzANl1cVACqo17KqBqzUSbX
riDi5FBIjgKqbgnvYUw1Z/V3BrUoHrcV9k2RmS8dyV97EC1QAWbBvlrZWW2C7JEOHWcIhcer
JEeYW3L6AQPcF05Ub/5Vacd7djjfVDxIycli31FQhPJQ6B2azI+zAwzzFYrmmyi+4sS9Nzrx
oagqQpTLNWnHwiMBXob7HUHBfDYo9O2OGf4rBIXe/weFf+WgoOzsDUFh341u5WHsSNtQ73Eg
zyd+rTfcqcndrSKX/18VVoQhDiiazxB8hGDVCMYTBNbEnmuWnPB+wNHNY3PP8w898EXnt3q/
y/nFI+c3XnZ+8wXnR4J96P5yYy8T9XsqXzNWVIsYGgnW+zaV7VU2T9c2qcGfYx7DawOs1Qmt
Y1wNU74Qkt+ZlTY6f+CisaqylAVxm/ssjJdI6A7+Tkj0MDUKMz+NtvD5S35pWk4Z/GKCOaje
he1hcXuN6Ep+H+pUH8dXeODNMcAaICbe/dTjPH+GwtaoIHhNqHm4/742U4QlN1Lgg1V5yZ6x
mxyuYRbOrJirm6o04tUNR/6TXfkpIsHOZ32GRcVzsK4DwPkzujnhS58nn9EOT0r57i65HD9E
Zx7MLmNCRne3uztMlnJ+wMWV/C6ynowOJvcwWaz5ZpDDiOcotLJ9bqV+WOEyoj0WpYcwi/ma
HwRePA7W8oV0zq9H5MsJh0ip7ps6+YZW2mq6Xqds6e4LgOl63eqjzsNpII3jYJtg77K9tQ3r
EfFv2AHRYrFnCdEO50AcQ719q1ZzNDX1ovTdCuAl+TsVQEUStWAaZlm9S4IaUXxUQb2wlwbc
/bRY31RwdweOVMEZRtuoCLlVQfxIPuN/WD7mPCny/7sC9qw3bSCg3OoboNeENHqvCCmMV/MM
880Z+WvdhjjMtUC+53FIHq3l/6wih67n6xvZqgGgJGXsKJXIHP6O8V+TPoYxd1Hk71kU39SH
n4L778atpjVCGIje8ytyVNBsrOtHFvbQ2nppC4E9lrIUzaKsNkGl6r/vTLILnkrPyZDMMGRe
3rz5G1xBHbeUDi1PKIUJORMMxdeQOchdIHGBBbOvPRFEfuDMkX+8sUak/R6VU7lcOm3Mej8P
b78deCLlZtkb/QO91NzKqth+/07K54Jyp7owUMfDSIiI5g88y4j5GjDaHJVL4Titt6m7Jc5y
+iGLk5TBi5Sf931nA76jDCjN00dss6GCxoHOA2310RqS1pwRBU0DJAr1AFMkW9IuSzmSuT6J
q0Qs8C/TliB7UrBjsE03PTVQORmd55mN1drVrNL9DuI96+G6+0Ecv7Bm6juCr6NicPu40L1t
8ceV4EkBkAUCWGvnjIL8ZHY0jb694khplP4jPdTUcPILijZca9Y6AAA=

--vtzGhvizbBRQ85DL--
