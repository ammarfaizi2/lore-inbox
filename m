Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263791AbREYQSx>; Fri, 25 May 2001 12:18:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263790AbREYQSq>; Fri, 25 May 2001 12:18:46 -0400
Received: from chmls05.mediaone.net ([24.147.1.143]:49379 "EHLO
	chmls05.mediaone.net") by vger.kernel.org with ESMTP
	id <S263789AbREYQSf>; Fri, 25 May 2001 12:18:35 -0400
Message-Id: <200105251618.f4PGIHx19617@chmls05.mediaone.net>
Date: Fri, 25 May 2001 12:18:25 -0400
From: Bryce Nesbitt <bryce@obviously.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.4 i686)
X-Accept-Language: de, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, sailer@ife.ee.ethz.ch,
        Bryce Nesbitt <bryce@obviously.com>
Subject: PROBLEM: USB Micropone, samples recorded at twice proper rate, 
 distortion
Content-Type: multipart/mixed;
 boundary="------------60713D0015DD8E206BC4D7A4"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------60713D0015DD8E206BC4D7A4
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

[1.] One line summary of the problem:
Sample rate wrong for USB microphone - distorted noisy sampling.


[2.] Full description of the problem/report:
The Andrea NC-7100 Microphone, which works great on the Mac & Win 98,
does not work under Linux.  Samples are recorded at exactly twice the proper
speed.  This can be verified by recording, then playing back at double
the normal rate.

The audio driver eventually confuses itself and registers the wrong dsp device.

The code is hard to follow because structures from the USB Audio Class spec
are parsed as absolute offsets with no comments, no names, no headers.


[3.] Keywords (i.e., modules, networking, kernel):
Kernel USB audio audio.c "USB Audio Class Driver" module microphone input dsp


[4.] Kernel version (from /proc/version):
Linux version 2.4.2-2 (root@porky.devel.redhat.com) (gcc version 2.96 20000731 (
Red Hat Linux 7.1 2.96-79)) #1 Sun Apr 8 20:41:30 EDT 2001


[7.1.] Software (add the output of the ver_linux script here)
Gnu C                  2.96
Gnu make               3.79.1
binutils               2.10.91.0.2
util-linux             2.10r
modutils               2.4.2
e2fsprogs              1.19
reiserfsprogs          3.x.0f
pcmcia-cs              3.1.22
PPP                    2.4.0
isdn4k-utils           3.1pre1
Linux C Library        2.2.2
Dynamic linker (ldd)   2.2.2
Procps                 2.0.7
Net-tools              1.57
Console-tools          0.3.3
Sh-utils               2.0
Modules Loaded         audio soundcore parport_pc lp parport autofs eepro100 ipc
hains ide-scsi scsi_mod ide-cd cdrom usb-uhci usbcore


[7.2.] Processor information (from /proc/cpuinfo):
[7.3.] Module information (from /proc/modules):
[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)
# cat /proc/bus/usb/devices 
T:  Bus=02 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  2 Spd=12  MxCh= 2
B:  Alloc= 11/900 us ( 1%), #Int=  1, #Iso=  0
D:  Ver= 1.00 Cls=09(hub  ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=0000 ProdID=0000 Rev= 0.00
S:  Product=USB UHCI Root Hub
S:  SerialNumber=d000
C:* #Ifs= 1 Cfg#= 1 Atr=40 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   8 Ivl=255ms
T:  Bus=02 Lev=01 Prnt=02 Port=01 Cnt=01 Dev#=  3 Spd=12  MxCh= 4
D:  Ver= 1.10 Cls=09(hub  ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=058f ProdID=9254 Rev= 1.00
S:  Manufacturer=ALCOR
S:  Product=Generic USB Hub
C:* #Ifs= 1 Cfg#= 1 Atr=e0 MxPwr=100mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   1 Ivl=255ms
T:  Bus=01 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=12  MxCh= 2
B:  Alloc=  0/900 us ( 0%), #Int=  0, #Iso=  0
D:  Ver= 1.00 Cls=09(hub  ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=0000 ProdID=0000 Rev= 0.00
S:  Product=USB UHCI Root Hub
S:  SerialNumber=d400
C:* #Ifs= 1 Cfg#= 1 Atr=40 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   8 Ivl=255ms
T:  Bus=01 Lev=01 Prnt=01 Port=01 Cnt=01 Dev#=  4 Spd=12  MxCh= 0
D:  Ver= 1.10 Cls=00(>ifc ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=0556 ProdID=0001 Rev= 0.01
S:  Manufacturer=AKM
S:  Product=AK5370
C:* #Ifs= 2 Cfg#= 1 Atr=80 MxPwr= 90mA
I:  If#= 0 Alt= 0 #EPs= 0 Cls=01(audio) Sub=01 Prot=00 Driver=audio
I:  If#= 1 Alt= 0 #EPs= 0 Cls=01(audio) Sub=02 Prot=00 Driver=audio
I:  If#= 1 Alt= 1 #EPs= 1 Cls=01(audio) Sub=02 Prot=00 Driver=audio
E:  Ad=81(I) Atr=01(Isoc) MxPS= 100 Ivl=  1ms

[7.5.] PCI information ('lspci -vvv' as root)
[7.6.] SCSI information (from /proc/scsi/scsi)
[7.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):


[X.] Other notes, patches, fixes, workarounds:
-----------------------------------------------------------------------
1> On boot, the USB mic takes over the normal audio.  "gmix"
shows only the USB mixer device.
2> After removing and reinserting the usb mic, both the
EMU10K1 sound card and the USB microphone show in "gmix".
3> Often after plugging in and out, it will register dsp number 35!
4> audio.c debugs should indicate which dsp devices was registered!!!!!!


/var/log/messages during a record session (using sox & rec)
----------------------------------------------------------------------
May 25 11:33:50 localhost kernel: usb_audio: set_format_in: usb_set_interface 1 
1
May 25 11:33:50 localhost kernel: usbaudio: set_format_in: device 2 interface 1 
altsetting 1 srate req: 8000 real 8000
May 25 11:33:50 localhost kernel: usbaudio: actual sampling frequency 8000
May 25 11:33:50 localhost kernel: usbaudio: set_format_in: USB format 0x10, DMA 
format 0x8 srate 8000
May 25 11:33:50 localhost kernel: usb_audio: set_format_in: usb_set_interface 1 
1
May 25 11:33:50 localhost kernel: usbaudio: set_format_in: device 2 interface 1 
altsetting 1 srate req: 8000 real 8000
May 25 11:33:50 localhost kernel: usbaudio: actual sampling frequency 8000
May 25 11:33:50 localhost kernel: usbaudio: set_format_in: USB format 0x10, DMA 
format 0x8 srate 8000
May 25 11:33:50 localhost kernel: usb_audio: set_format_in: usb_set_interface 1 
1
May 25 11:33:50 localhost kernel: usbaudio: set_format_in: device 2 interface 1 
altsetting 1 srate req: 8000 real 8000
May 25 11:33:50 localhost kernel: usbaudio: actual sampling frequency 8000
May 25 11:33:50 localhost kernel: usbaudio: set_format_in: USB format 0x10, DMA 
format 0x80000008 srate 8000
May 25 11:33:50 localhost kernel: usb_audio: set_format_in: usb_set_interface 1 
1
May 25 11:33:50 localhost kernel: usbaudio: set_format_in: device 2 interface 1 
altsetting 1 srate req: 44100 real 44100
May 25 11:33:50 localhost kernel: usbaudio: actual sampling frequency 44100
May 25 11:33:50 localhost kernel: usbaudio: set_format_in: USB format 0x10, DMA 
format 0x80000008 srate 44100
May 25 11:33:50 localhost kernel: usbaudio: dmabuf_init: bytepersec 88200 bufs 1
31072 ossfragshift 0 ossmaxfrags 0 fragshift 9 fragsize 512 numfrag 256 dmasize 
131072 bufsize 131072 fmt 0x80000008


Remove and reinsert microphone
---------------------------------------------------------------------------
May 25 11:35:34 localhost kernel: usbaudio: unregister dsp 3
May 25 11:35:34 localhost kernel: usbaudio: unregister mixer 0
May 25 11:35:34 localhost kernel: usb_audio_disconnect: note, called with -1

May 25 11:35:37 localhost kernel: usbaudio: device 3 audiocontrol interface 0 ha
s 1 input and 0 output AudioStreaming interfaces
May 25 11:35:37 localhost kernel: usbaudio: device 3 interface 1 altsetting 0 do
es not have an endpoint
May 23 22:38:43 localhost kernel: usbaudio: valid sample rate 48000
May 23 22:38:43 localhost kernel: usbaudio: valid sample rate 44100
May 23 22:38:43 localhost kernel: usbaudio: valid sample rate 22050
May 23 22:38:43 localhost kernel: usbaudio: valid sample rate 11025
May 23 22:38:43 localhost kernel: usbaudio: valid sample rate 8000
May 25 11:35:37 localhost kernel: usbaudio: device 3 interface 1 altsetting 1: f
ormat 0x00000010 sratelo 8000 sratehi 48000 attributes 0x01
May 25 11:35:37 localhost kernel: usbaudio: registered dsp 3
May 25 11:35:37 localhost kernel: usbaudio: constructing mixer for Terminal 2 ty
pe 0x0101
May 25 11:35:37 localhost kernel: usbaudio: workaround for broken Philips Camera
 Microphone descriptor enabled
May 25 11:35:37 localhost kernel: usbaudio: register mixer 0
May 25 11:35:37 localhost kernel: usb_audio_parsecontrol: usb_audio_state at cd8
ed540


Attached sample & kernel patch for extra debugging.  "audio.c" gives no clue as
to which section of the Audio Class Spec it is parsing, and uses hard-coded offets
into structures rather than the official names from the Class Spec.  This is not a good thing!

Bryce Nesbitt <bryce -at the machine- obviously.com>
--------------60713D0015DD8E206BC4D7A4
Content-Type: application/octet-stream;
 name="audio_c_diffs"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="audio_c_diffs"

KioqIGF1ZGlvLmMJRnJpIE1heSAyNSAxMTo0NjozMiAyMDAxCi0tLSBhdWRpby5jLnYJRnJp
IE1heSAyNSAxMTo0NzozOSAyMDAxCioqKioqKioqKioqKioqKgoqKiogMTk1LDE5OSAqKioq
CiAgI2RlZmluZSBTTkRfREVWX0RTUDE2ICAgNSAKICAKISAjZGVmaW5lIGRwcmludGsoeCkJ
cHJpbnRrIHgKICAKICAvKiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0gKi8KLS0tIDE5NSwxOTkgLS0tLQog
ICNkZWZpbmUgU05EX0RFVl9EU1AxNiAgIDUgCiAgCiEgI2RlZmluZSBkcHJpbnRrKHgpCiAg
CiAgLyogLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tICovCioqKioqKioqKioqKioqKgoqKiogNDc3LDQ4MSAq
KioqCiAgCWRiLT5idWZzaXplID0gbnIgPDwgUEFHRV9TSElGVDsKICAJZGItPnJlYWR5ID0g
MTsKISAJZHByaW50aygoS0VSTl9ERUJVRyAidXNiYXVkaW86IGRtYWJ1Zl9pbml0OiBieXRl
cGVyc2VjICVkIGJ1ZnMgJWQgb3NzZnJhZ3NoaWZ0ICVkIG9zc21heGZyYWdzICVkICIKICAJ
ICAgICAgICAgImZyYWdzaGlmdCAlZCBmcmFnc2l6ZSAlZCBudW1mcmFnICVkIGRtYXNpemUg
JWQgYnVmc2l6ZSAlZCBmbXQgMHgleFxuIiwKICAJICAgICAgICAgYnl0ZXBlcnNlYywgYnVm
cywgZGItPm9zc2ZyYWdzaGlmdCwgZGItPm9zc21heGZyYWdzLCBkYi0+ZnJhZ3NoaWZ0LCBk
Yi0+ZnJhZ3NpemUsCi0tLSA0NzcsNDgxIC0tLS0KICAJZGItPmJ1ZnNpemUgPSBuciA8PCBQ
QUdFX1NISUZUOwogIAlkYi0+cmVhZHkgPSAxOwohIAlkcHJpbnRrKChLRVJOX0RFQlVHICJk
bWFidWZfaW5pdDogYnl0ZXBlcnNlYyAlZCBidWZzICVkIG9zc2ZyYWdzaGlmdCAlZCBvc3Nt
YXhmcmFncyAlZCAiCiAgCSAgICAgICAgICJmcmFnc2hpZnQgJWQgZnJhZ3NpemUgJWQgbnVt
ZnJhZyAlZCBkbWFzaXplICVkIGJ1ZnNpemUgJWQgZm10IDB4JXhcbiIsCiAgCSAgICAgICAg
IGJ5dGVwZXJzZWMsIGJ1ZnMsIGRiLT5vc3NmcmFnc2hpZnQsIGRiLT5vc3NtYXhmcmFncywg
ZGItPmZyYWdzaGlmdCwgZGItPmZyYWdzaXplLAoqKioqKioqKioqKioqKioKKioqIDEyNzEs
MTI3NSAqKioqCiAgICogcmV0dXJuIHZhbHVlOiAwIGlmIGRlc2NyaXB0b3Igc2hvdWxkIGJl
IHJlc3RhcnRlZCwgLTEgb3RoZXJ3aXNlCiAgICovCi0gaW50IGFicyggaW50ICk7CiAgc3Rh
dGljIGludCB1c2JvdXRfc3luY19yZXRpcmVfZGVzYyhzdHJ1Y3QgdXNib3V0ICp1LCBwdXJi
X3QgdXJiKQogIHsKLS0tIDEyNzEsMTI3NCAtLS0tCioqKioqKioqKioqKioqKgoqKiogMTU2
NSwxNTY5ICoqKioKICAJCSAgICAgICAgZGV2LT5kZXZudW0sIHUtPmludGVyZmFjZSwgZm10
LT5hbHRzZXR0aW5nLCBkLT5zcmF0ZSwgZGF0YVswXSB8IChkYXRhWzFdIDw8IDgpIHwgKGRh
dGFbMl0gPDwgMTYpKSk7CiAgCQlkLT5zcmF0ZSA9IGRhdGFbMF0gfCAoZGF0YVsxXSA8PCA4
KSB8IChkYXRhWzJdIDw8IDE2KTsKLSAJCXByaW50ayhLRVJOX0VSUiAidXNiYXVkaW86IGFj
dHVhbCBzYW1wbGluZyBmcmVxdWVuY3kgJWRcbiIsIGQtPnNyYXRlKTsKICAJfQogIAlkcHJp
bnRrKChLRVJOX0RFQlVHICJ1c2JhdWRpbzogc2V0X2Zvcm1hdF9pbjogVVNCIGZvcm1hdCAw
eCV4LCBETUEgZm9ybWF0IDB4JXggc3JhdGUgJXVcbiIsIHUtPmZvcm1hdCwgZC0+Zm9ybWF0
LCBkLT5zcmF0ZSkpOwotLS0gMTU2NCwxNTY3IC0tLS0KKioqKioqKioqKioqKioqCioqKiAy
ODk2LDI5MDQgKioqKgogIAkJCQljb250aW51ZTsKICAJCQl9Ci0gCQkJLy8KLSAJCQkvLwlQ
YXJzZSBUeXBlIEkgRm9ybWF0IFR5cGUgRGVzY3JpcHRvciBmaWVsZHM6Ci0gCQkJLy8JCWJM
ZW5ndGgsIGJEZXNjcmlwdG9yVHlwZSwgYkRlc2NyaXB0b3JTdWJ0eXBlLCBiRm9ybWF0VHlw
ZQotIAkJCS8vCQliTnJDaGFubmVscywgYlN1YkZyYW1lU2l6ZSwgYkJpdFJlc29sdXRpb24s
IGJTYW1lRnJlcVR5cGUsIHRTYW1GcmVxCi0gCQkJLy8KICAJCQlmbXQgPSBmaW5kX2NzaW50
ZXJmYWNlX2Rlc2NyaXB0b3IoYnVmZmVyLCBidWZsZW4sIE5VTEwsIEFTX0dFTkVSQUwsIGFz
aWZvdXQsIGkpOwogIAkJCWlmICghZm10KSB7Ci0tLSAyODk0LDI4OTcgLS0tLQoqKioqKioq
KioqKioqKioKKioqIDI5NTIsMjk1NiAqKioqCiAgCQkJZm9yIChqID0gZm10WzddID8gKGZt
dFs3XS0xKSA6IDE7IGogPiAwOyBqLS0pIHsKICAJCQkJayA9IGZtdFs4KzMqal0gfCAoZm10
WzkrMypqXSA8PCA4KSB8IChmbXRbMTArMypqXSA8PCAxNik7Ci0gCQkJCXByaW50ayhLRVJO
X0lORk8gInVzYmF1ZGlvOiB2YWxpZCBkZXZpY2Ugc2FtcGxlIHJhdGUgJXVcbiIsIGspOwog
IAkJCQlpZiAoayA+IGZwLT5zcmF0ZWhpKQogIAkJCQkJZnAtPnNyYXRlaGkgPSBrOwotLS0g
Mjk0NSwyOTQ4IC0tLS0KKioqKioqKioqKioqKioqCioqKiAyOTU5LDI5NjUgKioqKgogIAkJ
CX0KICAJCQlmcC0+YXR0cmlidXRlcyA9IGNzZXBbM107CiEgCQkJcHJpbnRrKEtFUk5fSU5G
TyAidXNiYXVkaW86IGRldmljZSAldSAvICV1IGFsdHNldHRpbmcgJXU6IGZvcm1hdCAweCUw
OHggc3JhdGVsbyAldSBzcmF0ZWhpICV1IGJpdHMgJXUgYXR0ciAweCUwMnhcbiIsCiEgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIGRldi0+ZGV2bnVtLCBhc2lmaW4sIGksIGZw
LT5mb3JtYXQsIGZwLT5zcmF0ZWxvLCBmcC0+c3JhdGVoaSwgZm10WzZdLCBmcC0+YXR0cmli
dXRlcyk7CiEgCiAgCQl9CiAgCX0KLS0tIDI5NTEsMjk1NiAtLS0tCiAgCQkJfQogIAkJCWZw
LT5hdHRyaWJ1dGVzID0gY3NlcFszXTsKISAJCQlwcmludGsoS0VSTl9JTkZPICJ1c2JhdWRp
bzogZGV2aWNlICV1IGludGVyZmFjZSAldSBhbHRzZXR0aW5nICV1OiBmb3JtYXQgMHglMDh4
IHNyYXRlbG8gJXUgc3JhdGVoaSAldSBhdHRyaWJ1dGVzIDB4JTAyeFxuIiwgCiEgCQkJICAg
ICAgIGRldi0+ZGV2bnVtLCBhc2lmb3V0LCBpLCBmcC0+Zm9ybWF0LCBmcC0+c3JhdGVsbywg
ZnAtPnNyYXRlaGksIGZwLT5hdHRyaWJ1dGVzKTsKICAJCX0KICAJfQoqKioqKioqKioqKioq
KioKKioqIDI5NzMsMjk3NyAqKioqCiAgCQlyZXR1cm47CiAgCX0KLSAJcHJpbnRrKEtFUk5f
SU5GTyAidXNiYXVkaW86IHJlZ2lzdGVyZWQgZHNwICVkXG4iLCBhcy0+ZGV2X2F1ZGlvKTsK
ICAJLyogZXZlcnl0aGluZyBzdWNjZXNzZnVsICovCiAgCWxpc3RfYWRkX3RhaWwoJmFzLT5s
aXN0LCAmcy0+YXVkaW9saXN0KTsKLS0tIDI5NjQsMjk2NyAtLS0tCioqKioqKioqKioqKioq
KgoqKiogMzMyMCwzMzI1ICoqKioKICB9CiAgCi0gCi0gLy8JU2VlIEF1ZGlvIENsYXNzIFNw
ZWMsIHNlY3Rpb24gNC4zLjIuNQogIHN0YXRpYyB2b2lkIHVzYl9hdWRpb19mZWF0dXJldW5p
dChzdHJ1Y3QgY29uc21peHN0YXRlICpzdGF0ZSwgdW5zaWduZWQgY2hhciAqZnRyKQogIHsK
LS0tIDMzMTAsMzMxMyAtLS0tCioqKioqKioqKioqKioqKgoqKiogMzQ2OSwzNDczICoqKioK
ICAJCXJldHVybjsKICAKISAJY2FzZSBGRUFUVVJFX1VOSVQ6CQkJLy8gU2VlIDQuMy4yLjUK
ICAJCWlmIChwMVswXSA8IDcgfHwgcDFbMF0gPCA3K3AxWzVdKSB7CiAgCQkJcHJpbnRrKEtF
Uk5fRVJSICJ1c2JhdWRpbzogdW5pdCAldTogaW52YWxpZCBGRUFUVVJFX1VOSVQgZGVzY3Jp
cHRvclxuIiwgdW5pdGlkKTsKLS0tIDM0NTcsMzQ2MSAtLS0tCiAgCQlyZXR1cm47CiAgCiEg
CWNhc2UgRkVBVFVSRV9VTklUOgogIAkJaWYgKHAxWzBdIDwgNyB8fCBwMVswXSA8IDcrcDFb
NV0pIHsKICAJCQlwcmludGsoS0VSTl9FUlIgInVzYmF1ZGlvOiB1bml0ICV1OiBpbnZhbGlk
IEZFQVRVUkVfVU5JVCBkZXNjcmlwdG9yXG4iLCB1bml0aWQpOwoqKioqKioqKioqKioqKioK
KioqIDM1NDAsMzU0NCAqKioqCiAgCQlyZXR1cm47CiAgCX0KLSAJcHJpbnRrKEtFUk5fSU5G
TyAidXNiYXVkaW86IHJlZ2lzdGVyIG1peGVyICVkXG4iLCBtcy0+ZGV2X21peGVyKTsKICAJ
bGlzdF9hZGRfdGFpbCgmbXMtPmxpc3QsICZzLT5taXhlcmxpc3QpOwogIH0KLS0tIDM1Mjgs
MzUzMSAtLS0tCioqKioqKioqKioqKioqKgoqKiogMzcyNSwzNzMzICoqKioKICAJLyogd2Ug
Z2V0IGNhbGxlZCB3aXRoIC0xIGZvciBldmVyeSBhdWRpb3N0cmVhbWluZyBpbnRlcmZhY2Ug
cmVnaXN0ZXJlZCAqLwogIAlpZiAocyA9PSAoc3RydWN0IHVzYl9hdWRpb19zdGF0ZSAqKS0x
KSB7CiEgCQlkcHJpbnRrKChLRVJOX0RFQlVHICJ1c2JhdWRpbzogbm90ZSwgdXNiX2F1ZGlv
X2Rpc2Nvbm5lY3QgY2FsbGVkIHdpdGggLTFcbiIpKTsKICAJCXJldHVybjsKICAJfQogIAlp
ZiAoIXMtPnVzYmRldikgewohIAkJZHByaW50aygoS0VSTl9ERUJVRyAidXNiX2F1ZGlvX2Rp
c2Nvbm5lY3Q6IGVycm9yLCBhbHJlYWR5IGNhbGxlZCBmb3IgJXAhXG4iLCBzKSk7CiAgCQly
ZXR1cm47CiAgCX0KLS0tIDM3MTIsMzcyMCAtLS0tCiAgCS8qIHdlIGdldCBjYWxsZWQgd2l0
aCAtMSBmb3IgZXZlcnkgYXVkaW9zdHJlYW1pbmcgaW50ZXJmYWNlIHJlZ2lzdGVyZWQgKi8K
ICAJaWYgKHMgPT0gKHN0cnVjdCB1c2JfYXVkaW9fc3RhdGUgKiktMSkgewohIAkJZHByaW50
aygoS0VSTl9ERUJVRyAidXNiX2F1ZGlvX2Rpc2Nvbm5lY3Q6IGNhbGxlZCB3aXRoIC0xXG4i
KSk7CiAgCQlyZXR1cm47CiAgCX0KICAJaWYgKCFzLT51c2JkZXYpIHsKISAJCWRwcmludGso
KEtFUk5fREVCVUcgInVzYl9hdWRpb19kaXNjb25uZWN0OiBhbHJlYWR5IGNhbGxlZCBmb3Ig
JXAhXG4iLCBzKSk7CiAgCQlyZXR1cm47CiAgCX0KKioqKioqKioqKioqKioqCioqKiAzNzQz
LDM3NTggKioqKgogIAkJd2FrZV91cCgmYXMtPnVzYmluLmRtYS53YWl0KTsKICAJCXdha2Vf
dXAoJmFzLT51c2JvdXQuZG1hLndhaXQpOwohIAkJaWYgKGFzLT5kZXZfYXVkaW8gPj0gMCkg
ewogIAkJCXVucmVnaXN0ZXJfc291bmRfZHNwKGFzLT5kZXZfYXVkaW8pOwotIAkJCXByaW50
ayhLRVJOX0lORk8gInVzYmF1ZGlvOiB1bnJlZ2lzdGVyIGRzcCAlZFxuIiwgYXMtPmRldl9h
dWRpbyk7Ci0gCQl9CiAgCQlhcy0+ZGV2X2F1ZGlvID0gLTE7CiAgCX0KICAJZm9yKGxpc3Qg
PSBzLT5taXhlcmxpc3QubmV4dDsgbGlzdCAhPSAmcy0+bWl4ZXJsaXN0OyBsaXN0ID0gbGlz
dC0+bmV4dCkgewogIAkJbXMgPSBsaXN0X2VudHJ5KGxpc3QsIHN0cnVjdCB1c2JfbWl4ZXJk
ZXYsIGxpc3QpOwohIAkJaWYgKG1zLT5kZXZfbWl4ZXIgPj0gMCkgewogIAkJCXVucmVnaXN0
ZXJfc291bmRfbWl4ZXIobXMtPmRldl9taXhlcik7Ci0gCQkJcHJpbnRrKEtFUk5fSU5GTyAi
dXNiYXVkaW86IHVucmVnaXN0ZXIgbWl4ZXIgJWRcbiIsIG1zLT5kZXZfbWl4ZXIpOwotIAkJ
fQogIAkJbXMtPmRldl9taXhlciA9IC0xOwogIAl9Ci0tLSAzNzMwLDM3NDEgLS0tLQogIAkJ
d2FrZV91cCgmYXMtPnVzYmluLmRtYS53YWl0KTsKICAJCXdha2VfdXAoJmFzLT51c2JvdXQu
ZG1hLndhaXQpOwohIAkJaWYgKGFzLT5kZXZfYXVkaW8gPj0gMCkKICAJCQl1bnJlZ2lzdGVy
X3NvdW5kX2RzcChhcy0+ZGV2X2F1ZGlvKTsKICAJCWFzLT5kZXZfYXVkaW8gPSAtMTsKICAJ
fQogIAlmb3IobGlzdCA9IHMtPm1peGVybGlzdC5uZXh0OyBsaXN0ICE9ICZzLT5taXhlcmxp
c3Q7IGxpc3QgPSBsaXN0LT5uZXh0KSB7CiAgCQltcyA9IGxpc3RfZW50cnkobGlzdCwgc3Ry
dWN0IHVzYl9taXhlcmRldiwgbGlzdCk7CiEgCQlpZiAobXMtPmRldl9taXhlciA+PSAwKQog
IAkJCXVucmVnaXN0ZXJfc291bmRfbWl4ZXIobXMtPmRldl9taXhlcik7CiAgCQltcy0+ZGV2
X21peGVyID0gLTE7CiAgCX0K
--------------60713D0015DD8E206BC4D7A4
Content-Type: application/octet-stream;
 name="usb_8000.wav"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="usb_8000.wav"

UklGRiSZAABXQVZFZm10IBAAAAABAAEAQB8AAEAfAAABAAgAZGF0YQCZAACAgICAf3+AgICA
gICAgICAgIB/f4CAgIB/f39/gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA
gICAgICAgIB/f39/f3+AgICAgIB/f39/f39/f39/gICAgICAgIB/f39/f3+AgH9/f39/f39/
gIB/f39/f39/f39/f39/f39/f39/f39/f39/f39/gIB/f39/f39/f39/gICAgH9/f39/f39/
f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/
f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/
f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/
f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/
f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/gIB/f39/f39/f4CAf39/f39/f3+AgICA
f39/f39/gICAgH9/f39/f39/f39/f4CAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA
gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA
gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA
gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA
gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA
gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA
gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA
gICAgICAgICAgICAgICAgICAgICAgH9/gIB/f39/gIB/f4CAf39/f39/gICAgICAf3+AgH9/
f3+AgICAgICAgICAgICAgICAgIB/f4CAgICAgICAf39/f39/gICAgH9/f39/f4CAgICAgICA
f39/f39/gICAgH9/f3+AgH9/gIB/f39/f3+AgICAf39/f39/f39/f39/f39/f39/f39/f39/
f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/
f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/
f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/
f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/
f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/
f39/f39/gICAgICAf39/f4CAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA
gICAgICAgIB/f4CAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA
gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA
gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA
gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA
gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA
gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA
gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIB/f35+f39+fn5+fn5/f4CAf39/f39/
f39/f39/fn5+fn9/f39+fn5+f39/f39/f39/f4CAf39/f39/f39/f39/f39/f39/f39/f39/
f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/
f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/
f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/
f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/
f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/fn5/f39/f39/f39/f39/f39/f39/f39/
f39/f39/f39+fn9/f39/f39/f39/f39/fn5/f39/f39/f39/f39/f39/f39/f39/f39/f39/
f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/
f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/gIB/f39/f39/f39/f39/f39/
f39/f39/f39/f39/f39/f39/f3+AgH9/f39/f4CAf39/f4CAgIB/f39/f39/f39/f3+AgICA
gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA
gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA
gICAgICAgYGAgIGBgYGBgYCAgICBgYGBgICBgYCAgYGAgICAgICBgYGBgICBgYGBgICAgIGB
gYGAgIGBgYGAgIGBgYGAgICAgYGAgIGBgYGAgICAgYGBgYCAgICBgYCAgYGBgYCAgYGBgYCA
gICBgYCAgICBgYGBgICAgICAgYGAgIGBgICBgYCAgICBgYCAgICAgICAgICAgICAgICAgICA
gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA
gICAgICAf3+AgICAgICAgICAgICAgICAgICAgICAgICAgH9/gICAgICAgIB/f39/gIB/f4CA
gICAgH9/f39/f39/f39/f39/f3+AgH9/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/
f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/
f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/
f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/
f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/
f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/gIB/f39/gICAgH9/f3+AgH9/f39/f4CA
f39/f39/gIB/f39/f3+AgICAf39/f4CAf39/f39/gIB/f39/gICAgICAgICAgICAf3+AgICA
gICAgICAgICAgH9/gICAgICAf39/f4CAf39/f39/gICAgICAgICAgICAgICAgICAgICAgICA
gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA
gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA
gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA
gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA
gICAgICAgICAgH9/gICAgICAgICAgICAgICAgICAf3+AgICAgIB/f39/gICAgH9/f3+AgH9/
f3+AgH9/f39/f39/gIB/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/
f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/fn5/f39/f39/f39/
f39/f39/f39/f39/f39+fn9/f39+fn9/f39+fn5+f39/f35+fn5/f35+fn5/f39/fn5/f39/
fn5+fn5+fn5/f35+fn5+fn5+fn5+fn5+fn5+fn9/f39+fn5+f39/f35+fn5+fn9/f39+fn9/
f39+fn5+fn5+fn9/fn5+fn9/fn5+fn5+fn5/f35+fn5/f39/fn5+fn5+fn5+fn5+f39/f35+
fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+f39/f35+fn5/f39/f39+fn5+f39/f35+fn5/f39/
f39+fn5+f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/
f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f3+AgICAf39/f4CAf3+AgICAgICAgICA
gICAgH9/f39/f39/gICAgICAgICAgICAgIB/f4CAgICAgICAgICAgICAgICAgICAgICAgICA
gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBgYCAgYGAgICA
gICAgICAgICAgICAgICAgIGBgICAgIGBgICAgICAgICBgYGBgICAgICAgYGBgYCAgICBgYGB
gICAgIGBgYGAgICAgICBgYCAgICAgIGBgYGBgYGBgYGBgYCAgICBgYGBgICBgYGBgYGBgYCA
gYGBgYCAgYGBgYGBgICAgICAgYGAgICAgYGAgICAgICBgYGBgICAgIGBgYGAgICAgICAgICA
gICAgICAgICAgICAgYGAgICAgYGAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA
gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA
f39/f4CAgICAgH9/gICAgH9/f3+AgH9/f39/f4CAgICAgH9/f39/f39/gICAgICAf39/f39/
f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/gICAgH9/f39/f39/
f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/
f39/f39/f39/f35+f39/f39/fn5/f39/f39/f39/f39/f35+f39/f39/fn5+fn9/f39+fn5+
f39+fn5+fn5/f39/f39+fn5+f39/f39/f39/f35+fn5+fn5+f39/f39/f39+fn9/f39+fn5+
fn5+fn9/f39/f39/f39/f39/f39/f39/f39+fn5+f39+fn5+f39/f39/fn5/f39/f39/f39/
f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/
f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/
f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/
f39/f39/f39/f39/f3+AgICAf3+AgH9/f3+AgICAgICAgICAf3+AgICAgICAgICAgICAgICA
gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA
gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA
gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA
gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA
gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA
gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA
gICAgICAgICAgICAgICAgICAgICAgICAgICAgH9/gICAgICAgICAgICAgICAgICAgICAgICA
gICAgICAgICAgICAgIB/f4CAgIB/f4CAgICAgICAf3+AgICAf39/f4CAgICAgH9/f3+AgICA
f3+AgICAgICAgH9/f39/f39/f39/f39/f39/f39/f39/f39/f39/f4CAf39/f39/f39/f39/
f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/
f39/f39/f39/f39/f39/f4CAf39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/
f39/f39/gIB/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/
f39/f39/f39/f39/f39/f39/f39/f4CAf39/f39/f39/f39/f39/f39/f39/f39/f39/f39/
f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/
f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/
f39/f39/f39/f39/f39/f4CAf3+AgH9/f3+AgH9/gICAgH9/f39/f39/f39/f39/gICAgH9/
gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA
gICAgICAgIB/f4CAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA
gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA
gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA
gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIB/f4CAgICAgICAgICAgICAgICAgICA
gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA
gICAgICAgICAgH9/gIB/f4CAgIB/f39/f39/f39/f39/f4CAgIB/f39/f39/f4CAgIB/f39/
f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/gIB/f39/
f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/
f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/
f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/
f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/
f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f3+AgH9/
f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/gIB/f39/
f39/f39/f39/f4CAgIB/f39/f39/f39/f39/f4CAf39/f39/f3+AgH9/f3+AgICAgIB/f39/
f39/f4CAgICAgICAgICAgICAgICAgICAgIB/f39/f3+AgICAf39/f39/f3+AgICAgICAgICA
gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA
gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIB/f4CAgICAgICAgICAgICA
gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA
gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA
gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA
gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA
gICAgICAgICAgICAgICAgICAgICAgICAf39/f39/f39/f39/gIB/f39/gICAgICAgICAgICA
gICAgICAgICAgICAgICAgH9/f3+AgH9/f3+AgICAgIB/f4CAgICAgICAgICAgICAf39/f39/
gICAgICAf39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/gIB/f39/
f3+AgICAgICAgH9/f3+AgH9/f3+AgH9/f39/f39/f39/f39/f39/f39/f3+AgH9/f39/f39/
f39/f39/f39/f39/f39/f39/f39/f39/f3+AgH9/gIB/f4CAf39/f39/f39/f39/f39/f39/
f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/
f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f3+AgICAgIB/f39/f39/f4CA
f39/f4CAf39/f39/f3+AgICAf3+AgICAgICAgH9/f3+AgICAgICAgICAf39/f4CAgICAgICA
f39/f4CAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA
gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA
gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA
gICAgICAgICAgICAgICAgH9/gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA
gICAgICAgICAgICAf3+AgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAf3+AgICA
gICAgICAgIB/f4CAf39/f39/gICAgICAf39/f39/f39/f4CAgICAgICAf39/f39/gICAgH9/
gIB/f39/f39/f39/gIB/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/
f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/
f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/
f39/f39/f39/f39/f39/f39/f3+AgH9/f3+AgICAgIB/f4CAgICAgICAgICAgICAgICAgICA
gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA
gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA
gICAgICAgICAgICAgICAgICAf3+AgICAgICAgH9/f39/f4CAgICAgICAgICAgICAgICAgICA
f39/f4CAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgH9/
gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA
gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIB/f4CAgIB/f39/f39/f39/f39/f39/
f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/
f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/
f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/
f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/gIB/f39/f39/f39/gICAgICAgICAgICA
gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAf39/f39/f39/f39/
f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/
f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/
f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/
f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/
f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/
f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/
f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/
f39/f39/f39/f39/f39/f39/f39/f39/f3+AgICAf3+AgICAf3+AgH9/f3+AgH9/gICAgICA
f39/f4CAf3+AgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA
gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA
gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA
gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA
gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA
gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA
gICAgICAgICAgICAgICAgICAgICAgICAgYGBgYGBgICBgYGBgYGBgYCAgYGAgICAgYGBgYGB
gYGBgYCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA
gICAgICAgICAgICAgICAgIGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGB
gYGBgYGBgICAgICAgICAgICAgICAgICAf39/f39/f39/f39/f39/f39/f39/f39/f3+AgICA
gICAgICAgICAgIGBgYGBgYGBgoKCgoKCgoKCgoKCgoKCgoKCg4OCgoKCgoKCgoKCgoKCgoKC
gYGBgYGBgYGAgICAgIB/f39/fn5+fn5+fn59fX19fX18fHx8fHx7e3t7e3t8fH19fX1+fn9/
gICCgoODhISFhYaGh4eHh4eHh4eHh4aGhoaFhYWFhISEhISEhISDg4ODg4ODg4ODgoKBgYCA
f39+fn19e3t5eXd3dXVycnBwbm5ra2pqbm51dX19gYGDg4WFiIiMjI+PkJCPj42NiYmFhYOD
g4OBgX9/fHx7e3x8fn6BgYSEhYWGhoaGh4eIiImJiYmHh4SEgYGAgH9/fn59fXx8e3t7e3x8
fHx7e3l5dXVycnBwbm5sbGxscHB3d319f3+CgoWFioqOjpCQj4+OjouLiIiFhYSEgYF9fXp6
eXl5eXt7fHx+foGBg4OFhYeHiIiIiIeHhYWDg4GBgIB+fnx8e3t7e3t7e3t8fH19fX19fX5+
fn5+fn19fHx7e3t7enp5eXl5eHh4eHl5enp6ent7fHx9fX9/gYGCgoODhISFhYaGhoaGhoaG
hYWEhIODg4ODg4KCgoKCgoODg4ODg4SEhISEhIODgoKCgoCAfn58fHt7enp4eHZ2c3NwcG1t
aWlnZ2ZmZWVlZWtrdXV7e35+goKKipCQkZGQkI+Pjo6KioWFgoJ+fnl5dXV0dHV1dnZ3d3p6
fn6CgoSEh4eJiYmJiIiIiIuLioqCgn5+f39/f319fHx8fH5+f3+AgIKCgYF+fn5+goKCgn19
eXl5eXl5d3dzc3Bwb29ubm9vb29ubmtraWlxcXx8fn54eHl5g4OKioqKh4eFhYaGhoaHh4WF
f397e319goKBgX5+gICFhYyMjo6MjIuLi4uLi4yMh4eBgYCAgYGAgH19e3t6enp6e3t6end3
cnJubmtrZWVeXlhYU1NRUWNjenp3d21tgYGXl5SUkJCSko+PjIyMjIWFeXlvb25udHRxcWZm
amp2dnp6fn6Gho6OkJCTk5ubm5uQkIyMjo6JiYSEhISAgH5+hISGhoSEhISHh4uLioqIiIaG
goJ/f3x8dXVtbWdnYmJdXVhYUlJISEVFbGyCgmlpcXGPj5qan5+cnJGRkZGUlJCQg4Nra2lp
dnZubmNjZWVqanV1gICCgoqKk5Ofn6iompqTk5iYk5OLi4eHfn6AgIODg4OBgX9/hYWLi4mJ
ioqJiYiIioqGhn5+d3dycm5uZmZdXVpaV1dVVUxMS0tra3NzcHCJiZaWjY2SkqWlnJyNjY+P
kZGCgnl5eXlxcWtrbm5xcW1tcHCAgImJioqTk5ycm5udnZ2dlZWPj4+PioqDg4GBgIB+foCA
gYGAgIGBhISFhYSEhISEhIKCfn55eXV1cXFvb2xsampoaGdnZWVgYGtrenpycnZ2fX2Li4qK
iYmMjIuLkZGPj4uLhISGhoiIgYF9fXp6fX19fX5+f39/f4WFiYmKiomJioqLi4mJhoaDg4KC
goKCgoGBgICCgoKCg4OCgoKCg4OEhIODgoKCgoKCgYGAgH9/f39/f39/f39+fn5+fn5+fn19
fX18fH5+f39+fn5+f3+BgYGBgYGBgYKCgoKDg4KCgoKDg4ODg4ODg4ODhISFhYSEhISFhYWF
hYWFhYSEhISFhYWFhISEhIWFhYWEhISEhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWEhISE
hISEhISEg4ODg4ODg4OCgoKCgoKCgoKCgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGCgoKC
goKCgoKCgoKCgoKCg4ODg4ODg4ODg4ODg4ODg4ODg4ODg4ODg4ODg4ODg4ODg4ODg4ODg4OD
g4ODg4ODg4ODg4KCgoKCgoKCgoKCgoGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGB
gYGBgYGBgYGBgYGBgYGBgYGBgYGBgYKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKBgYGB
gYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYCAgYGBgYCAgICAgICAgICAgICAgICAgICA
gICBgYCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA
gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA
gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA
gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA
gICAgICAgICAgICAgICAgICAgICAgH9/f3+AgICAgIB/f4CAgICAgICAf3+AgICAgICAgICA
gICAgH9/f3+AgH9/gICAgICAf39/f4CAf39/f39/f39/f39/f39/f39/f39/f39/f39/f39/
f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/
f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/
f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f35+fn5+fn9/
f39+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn19
fX1+fn19fn5+fn5+fn59fX19fX19fX19fX19fX5+fX19fX19fX19fX19fn5+fn19fn5+fn19
fX1+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5/f39/f39/f39/f39/f4CAf3+NjZKSjIx8fG1t
amp1dYSEi4uHh3x8dHR0dHl5jY2bm5WVgIBnZ2Rkd3eWlp+fk5N4eGlpa2t+fo2Nj4+AgHFx
a2t0dIWFkJCOjn9/fHyBgYmJjY2BgX19d3d6ent7gIB/f319dHRsbGVlgICgoLKynJx9fWho
cXGHh5eXk5N/f2lpZGRzc4qKl5eUlIODdXV0dH5+i4uPj4eHeXlwcHR0gICKioqKgIB3d3Nz
eXmBgYiIiIiCgnp6dnZ6eoODiYmJiYCAeHhzc3h4gICGhoSEgIB6enh4eXmHh5aWoaGbm4eH
dHRtbXZ2hISPj4uLgoJ2dnR0e3uIiI+PjIyCgnl5d3d9fYSEiIiDg319d3d4eH19hYWGhoSE
fX16ent7gYGFhYeHg4N9fXl5e3t+foKCg4OCgn5+fHx7e319gYGDg4SEgYGAgH5+fn5+fn5+
gICBgYKCf398fHp6enp+fn9/fX15eXh4eHh6enx8enp3d4GBhYWGhoSEiYmLi46Oh4d9fXR0
dHR6eoWFiYmGhoGBfn5/f4WFjIyMjIaGf394eHl5fn6CgoSEgYF8fHl5fHyBgYaGiIiGhn9/
fHx6en5+gYGEhIWFhISEhIWFhYWGhoODgIB9fXx8fX2AgIKCgoKBgX9/gICAgIODhISHh4mJ
iYmGhoGBf39+fn9/gICCgoODg4OCgoGBgICCgoWFhoaDg4KCgoKDg4KCgoJ+fnt7enp7e319
gYGDg4KCgICAgICAgoKEhISEgoKAgH5+fX1/f4GBgYGAgH9/f3+AgIODhYWDg39/fn59fX5+
gICBgYCAfn5+fn5+gICAgH5+fX18fH19fn6AgIKCgYF+fnt7e3t7e3x8fHx8fHx8e3t8fHx8
fHx8fHt7e3t6enh4eHh7e319fX18fHx8e3t7e3t7e3t6enl5eHh2dnV1dnZ4eHt7fHx9fXx8
e3t7e3x8fX19fXx8eXl3d3d3eXl7e35+gICAgH9/fn5+fn9/f39+fnx8enp5eXp6fHx9fX19
fHx6enl5eXl6ent7e3t7e3p6eXl4eHl5enp8fHx8enp4eHZ2dXV1dXd3eHh3d3Z2dHRzc3R0
dXV3d3h4eHh2dnV1dHR2dnp6fHyAgIKChISEhIWFhYWHh4mJi4uNjYyMjIyLi4uLi4uMjI2N
jIyLi4uLi4uMjI2NjIyMjIqKiIiFhYSEhISEhIGBfn56enR0cnJxcXFxb29ubnV1fHyKipiY
oqKoqKeno6OcnJiYlpaVlZWVlZWUlJKSk5OXl5yco6Onp6mpp6ejo56emZmXl5WVk5ORkY6O
i4uJiYiIh4eGhoWFg4OBgXx8d3dwcGhoX19XV09PSkpFRUtLWVlmZnp6iIiOjo2NiIh/f3R0
b29paWJiXFxVVVBQTU1PT1dXYGBra3Nzd3d1dXFxbm5sbGxsbGxqamVlXl5ZWVdXWlpgYGdn
bGxsbGhoYmJbW1ZWU1NQUExMRkY/PzY2LS0mJh8fFBQhITk5Tk5xcYWFj4+IiHx8bm5cXFpa
V1dUVFBQSkpGRkRES0tbW2trfHyFhYaGgIB4eHJyb29ycnl5fHx/f319enp4eHh4fn6Dg4mJ
i4uJiYWFf397e3h4dnZzc29vbGxnZ2NjXV1VVUtLPDwuLj4+Wlp2dqKiubnBwba2o6OSkn19
e3t6enZ2cnJqamRkYmJra4CAk5OlpbCwr6+mppublJSQkJOTm5uenp6enJyYmJeXmpqioqmp
rq6urqiooaGampWVk5ORkY+Pi4uGhoKCfHx1dWtrX19ISDo6V1d4eKOj0tLj4+LixcWtrZaW
hISKioyMiIh/f3NzbGxuboKCoKC2tsbGyMi7u6qqnJyXl5aWl5ecnJubmZmgoKmptra/v8PD
vLyurqOjnJybm6CgpKSiopmZkJCJiYWFiIiLi4iIfHxoaE9PMDA9PW1tlZXMzOnp6OjQ0Kys
nJyKiomJkpKKinl5aWleXmVleHibm7m5wsLDw7W1oqKXl5SUl5eWlpOTjIyDg4WFlpatrb+/
x8fAwKurmJiPj4+PlZWbm5mZjo6Cgnx8fX2Dg4mJh4d4eGFhSUktLSEhUFCCgqmp1dXa2srK
rKyXl5KShoaHh4SEa2tXV1FRWFhvb4yMq6u3t7CwqKienpSUlJSTk46OgoJ3d3l5g4OYmK2t
tbWwsKOjlZWPj5CQl5eZmZCQhYV5eXNzd3d/f4SEgIB0dGRkUVFBQS4uISFKSnl5lpbBwcrK
v7+pqZSUjo5/f3V1cXFcXElJS0tWVm1thoacnKenoaGbm5mZkpKNjYiIfX1ycmxsdHSFhZWV
paWnp52dk5ONjYyMj4+Pj4uLf391dXNzc3N5eXx8d3dubmFhVlZLSz09KSkeHkxMeXmXl7+/
xcW0tJycioqGhnx8bW1nZ1FRPT1HR1tbdHSMjJqanp6Xl5CQlpaVlYqKgIBwcGRkZWV3d4+P
m5ugoJ+fk5OMjJCQk5OQkIeHfX10dHBwdnZ+fnx8dXVubmVlYWFdXVNTQEAgIAwMPDx/f6Cg
vb3BwaiokZGKipOTkJByclhYRUUzM0JCaGiBgYqKiIiHh5CQmJijo6enj49vb2FhY2Nzc4qK
mJiVlYiIhoaRkZubnJyWloeHdnZ0dH19hISAgHNzaGhjY2VlbW1ubl1dQ0MrKxUVHh5oaKCg
paWgoJycm5ufn6OjoKCFhVJSPT1MTFpaZWVtbWxsa2t2do+Pq6utrZaWhIR6enZ2fX2EhIOD
fHx6eoaGlZWWlpKSjY2Hh4aGjIyQkIqKe3txcXJyc3Nycm9vZ2dfX1hYUVFJSTU1Gho2Nn5+
nJyVlZCQmZmmpqmpn5+UlHl5VlZTU2dna2tfX1VVXFxycoWFkJCYmJWViYmKipWVlZWIiHx8
enqBgYeHiYmIiISEgYGJiZaWl5eNjYKCgYGFhYODenpycmtraGhqamlpYmJVVUlJPz80NEtL
f3+RkX5+d3eQkK+vtLSYmICAgICCgn19dnZra15eW1tmZnd3fX1zc29vgYGWlpiYjIyEhIqK
mZmdnZGRgoJ7e39/h4eGhn5+enp/f4mJjY2FhXp6enp/f4GBfHxycm9vdHR2dnJyZ2dfX1pa
WFhmZnt7enptbW9vh4eampSUf397e4+PnJyNjXd3dHSDg4qKfn5ubm9vfn6EhHx8dHR4eIKC
h4eFhYWFioqOjo2Nh4eBgX9/gICCgoODgoKBgYGBgoKCgoGBf39/f39/gIB+fnx8fHx8fHt7
eXl4eHh4d3d5eX5+fn55eXh4fHx/f35+enp6en5+gYF/f3x8fn6CgoODgIB+foGBhISEhIGB
f3+BgYKCgYGAgICAgYGCgoGBgYGCgoKCgoKCgoKCg4ODg4ODg4OEhISEg4ODg4SEhISCgoGB
gICAgH9/fn58fHx8fHx8fHp6enp7e3x8fHx7e3t7fHx9fX5+fn5+fn9/gICAgICAgICAgICA
gICAgICAgICAgICAgICAgICAgYGBgYGBgYGCgoKCg4ODg4ODg4ODg4SEhISEhISEhISEhIOD
goKCgoGBgIB/f35+fX19fX19fHx7e3x8fHx8fHt7e3t8fHx8fX19fX19fn5/f39/f39/f39/
gICAgICAgICAgICAgICAgICAgYGBgYGBgYGBgYGBgoKCgoODg4ODg4ODhISFhYSEhISEhISE
hISDg4KCgoKBgYCAgIB+fn5+fX19fXx8fHx8fHx8e3t8fHx8fHx9fX19fX2CgoKCfn6CgoOD
fX2AgIeHgIB9fYSEgIB9fYODg4OBgYSEgoKFhYmJgoKGhoqKhISHh4mJh4eKioiIiYmKioeH
h4eFhYGBgYF9fXt7eHhxcW1taWl8fHV1aWmBgYWFgYGFhYyMkJCQkI2NioqKiouLgIB6en9/
e3tzc3R0eXl5eXd3fHyEhI2Nj4+RkZubm5uSkpSUkpKMjIiIhoaEhIWFhISBgYODhYWAgIGB
goJ+fnp6dnZvb2NjV1dLS3V1ZmZJSYODi4t+fnt7qqqcnIiIm5ucnJCQg4OEhICAeHhvb2pq
dXVvb2pqc3OAgHp6fn6MjJWVmJiSkqGhoKCPj4+PlpaHh319iYmGhnx8gYGGhoGBfn6BgYGB
fn53d3d3cHBiYk9PWFh+fkNDWVmMjHR0Z2eNjaameHiSkqSkkpKEhJKSkJB6ent7eXl3d21t
bW1zc3Jyb290dIKCfX2Dg5iYj4+Tk56elpaPj5aWjY2FhYyMhISAgISEgYF7e4CAfX15eX19
eXl1dXNzbGxbW19fgoJMTGNjiYltbWlpjIyTk3Fxk5OamoeHh4eWloqKfn6GhoGBenp0dHp6
d3dxcXR0eXl4eHZ2hISHh4SEjY2Tk42NjY2Tk4uLh4eLi4eHgICCgoCAenp6enp6eXl3d3h4
d3d0dHFxbW1kZHd3amphYX19c3Nubnp6h4d1dYKCi4uDg4KCi4uIiIGBhYWEhH9/fHx+fnx8
d3d5eXt7eHh5eX5+fn5/f4WFhoaFhYiIiIiFhYaGhoaBgYGBgYF+fn19fX18fHx8e3t7e3p6
enp4eHd3dHRycnl5cHB0dHp6dXV4eHx8fX16eoKCgICAgIKChISBgYKCg4OCgoCAgICAgH19
fX19fX19fHx9fX5+fn5/f4GBgYGAgIKCgoKAgIGBgoKBgYGBgoKBgYGBgoKBgYCAgYGAgH9/
gIB/f35+fn59fXt7fHx8fHp6fHx7e3x8fX19fX19fn5/f39/gICAgICAgICCgoKCgYGBgYKC
gYGBgYGBgYGAgIGBgYGAgIGBgYGBgYGBgoKCgoKCgoKCgoODg4ODg4ODg4OEhIWFhYWDg4WF
iIiIiIWFg4OCgoCAf39+fnx8e3t7e3p6eHh6enx8fX1+foGBgoKCgoSEhYWFhYaGh4eFhYSE
hISDg4ODg4ODg4ODg4OEhIWFhYWHh4iIiIiIiIiIiIiIiImJiYmIiIiIh4eGhoWFhYWDg4KC
gIB+fnt7eHh0dHBwcHBzc3V1c3N2dnl5enp8fIKChISFhYiIioqIiImJioqJiYeHiIiHh4SE
hISEhIKCg4OEhISEhISFhYaGhoaHh4eHiIiHh4iIiIiJiYiIiIiIiIaGhYWEhIODgIB+fnt7
d3dycm5ubm5xcXNzcXF1dXh4eXl7e4KCg4OFhYmJioqHh4iIiYmHh4eHiIiGhoODhISDg4KC
g4OEhISEhISFhYaGhoaHh4iIiIiIiIiIiYmJiYiIiYmIiIaGhYWEhIGBf399fXp6dXVwcG1t
bm5ycnFxcnJ2dnh4eXl9fYGBg4OFhYiIiIiGhoiIh4eGhoaGh4eEhIKCg4OCgoGBgoKDg4OD
g4OEhISEhYWGhoaGhoaHh4eHh4eIiIiIh4eHh4WFhISDg4GBf398fHp6dnZxcWxsbGxubnBw
b29ycnR0dXV4eHx8f3+BgYSEhYWFhYWFhYWEhISEhISDg4KCgYGAgICAgICBgYKCgoKCgoOD
g4ODg4SEhISEhISEhYWFhYWFhYWEhIODgoKBgX9/fX17e3l5dnZycm1tampra25ubW1ubnFx
c3N0dHh4e3t9fYCAg4ODg4ODg4ODg4KCg4OCgoGBf39/f39/fn5/f4CAgICAgIGBgYGBgYKC
g4OCgoODg4ODg4ODg4ODg4ODgoKBgYCAfn59fXt7eXl2dnNzbm5qamtrbW1sbG1tcHBxcXJy
dnZ6ent7fn6BgYKCgoKDg4ODgoKCgoKCgYGAgH9/f39/f4CAgICAgICAgICBgYGBgYGCgoKC
g4ODg4ODg4ODg4ODg4OCgoGBgIB/f35+fX17e3l5dnZ0dG9vbGxsbG5ubm5vb3FxcnJ0dHZ2
eXl8fH9/gYGCgoKCg4ODg4ODg4ODg4KCgYGBgYGBgYGCgoKCgoKCgoKCgoKCgoKCg4ODg4OD
g4ODg4ODg4OEhIODg4OCgoGBgICAgH5+fX17e3l5d3d0dHFxcHBwcHFxcXFycnR0d3d4eHt7
fX1/f4GBhISFhYWFhoaGhoWFhYWFhYSEg4OEhIODg4ODg4ODg4ODg4ODg4ODg4ODg4ODg4OD
g4ODg4ODhISDg4ODg4OCgoKCgYGBgYCAf39+fn19e3t6enh4d3d2dnZ2dnZ2dnd3eHh5eXp6
fHx9fX9/gICCgoODhISEhIWFhYWFhYWFhoaGhoaGhoaGhoWFhYWFhYWFhYWFhYSEhISEhISE
g4ODg4ODg4ODg4ODgoKCgoKCgoKCgoGBgICAgICAgIB/f35+fHx7e3t7enp6enp6e3t7e3t7
fHx9fX5+f3+AgIGBgoKDg4SEhISFhYWFhYWFhYWFhYWFhYWFhYWEhISEhISEhIODg4ODg4OD
goKCgoKCgoKCgoKCgoKBgYGBgYGBgYGBgYGAgICAgICAgH9/f39/f39/f39+fn5+fn5+fn5+
fn5+fn5+fn5+fn9/f39/f4CAgICBgYGBgYGCgoKCgoKBgYGBgoKBgYGBgYGBgYGBgYGBgYGB
gYGBgYGBgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgH9/f3+AgH9/
f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/
f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/
f39/f39/f39/f39/f39/f39/f39/f39/f39+fn5+f39/f39/f39/f35+f39/f39/f39/f39/
f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/
f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/
f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/
f39/f39/f39/f39/f39/f39/f39/f4CAf3+AgICAgICAgICAgICAgICAgICAgICAgICAgICA
gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA
gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgYGBgYCAgYGBgYGBgYGBgYGB
gYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGB
gYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGB
gYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYWFg4N+foiIgYF/f4mJ
gYGCgpGRfHyMjIiIg4OLi3x8jo6Dg4WFhoaFhYqKgoKIiIeHjY2CgoqKhoaGhoKCiYmIiIaG
iYmHh4eHh4eCgoiIhYWDg4aGg4OJiYKCiIiFhYmJhISHh4aGiYmCgoaGioqCgoeHgoKIiIKC
hoaAgIWFhoaAgISEgoKEhIKCgoKEhICAhYV9fYaGfX2Cgn9/gYGAgH9/g4N8fIKCfX2Cgnx8
goJ9fYCAfn58fICAfX1+fnp6g4N7e3x8fn59fX19eHh+fn19fHx2dnx8fn55eXZ2eXmAgHl5
c3OBgXx8dnZ2dnp6enpzc3l5d3d/f3JyfX18fHt7eHh6en9/eXl8fHd3fHx6enh4e3t5eX19
eHh8fHt7fHx8fHh4fHx7e319fX1/f3p6fn58fHx8enp8fH9/e3t+fnx8fn58fH19fX1/f3t7
fX1/f35+fX19fX9/fn5+fn19f39/f3x8f39+fnx8fX1+fnp6fn58fHt7fHx/f3l5e3t+fnp6
enp8fHt7enp7e3p6e3t7e3p6enp9fXx8e3t+fnt7enp7e3l5eHh5eXd3eHh7e3h4dXV5eXp6
dXV4eHp6eHh3d3Z2eHh3d3V1dXV6end3dXV5eXt7eXl6enl5e3t7e3p6eXl9fXx8e3t9fYGB
gICAgISEgoKEhISEhoaGhoeHhoaIiIqKhoaHh4yMioqIiI6Oj4+MjJCQkJCPj5KSkZGOjpKS
kpKMjJGRlJSPj4+PkpKPj42NjIyKioiIiIiEhIKChYWAgH9/goJ/f35+gIB8fHx8fX15eXl5
eHh2dnR0dHRxcXFxb29tbW1tbGxsbGxsbW1paWlpampnZ2VlZ2dpaWVlZmZpaWdnZWVpaWZm
ZGRpaWdnZGRqampqZ2dqamtraWlra21ta2tsbHBwbGxubnFxbm5tbXNzc3NubnJyeHh0dHNz
eXl3d3V1eHh4eHZ2eXl5eXd3enp6end3enp7e3l5eXl7e3l5eXl6enp6eHh5eXh4dnZ3d3d3
dnZ1dXZ2dXV1dXR0dHR2dnNzdHR2dnNzcXFzc3JycHBxcXJyb29ycnFxbW1wcHJycHBwcHR0
c3N1dXp6fX2AgIaGh4eHh4qKioqGhoaGiIiFhYWFiIiHh4aGiIiIiIaGhoaHh4aGhYWFhYOD
gYGAgH5+fn5+fn19fHx7e3h4d3d3d3d3dnZ1dXR0cXFqamZmYWFbW25ufHx6eoKCk5OUlImJ
ioqIiIODgIB7e3p6gICBgXx8hISKioiIhYWLi5OTkpKOjpCQlZWTk42Ni4uPj4+PjY2OjpSU
l5eUlJSUlpaUlI+PjIyMjIyMiYmHh4mJioqFhYKCg4OAgHp6dHRnZ3h4kJCSkpiYq6u1taen
oKCenpeXj4+KioeHioqSkpCQkpKcnKCgmpqbm5+fnZ2Xl5aWlJSWlpqamJiTk6Kiq6ufn52d
p6ejo5iYmJiZmZeXlpaTk5OTmJiXl4+PkJCUlI2NhYWHh4aGf394eHJybGxlZVhYXV2Ojpyc
jY2ZmbGxrKyVlY2NhoaDg3x8cHBycoGBiIiFhYyMmZmampSUkpKRkY2NhoZ/f39/g4OFhYSE
iYmRkZSUlJScnJubmpqcnJaWjo6NjY6OiIiKio+PkZGTk5aWk5ORkY+PiIiCgoKCgIB5eXh4
eXlycmtrZGRYWEhIf3+trYWFj4+zs7u7lJSLi4WFe3t7e25uZmZ2dpCQjIyJiZubpaWampGR
j4+Hh4GBe3t1dXp6hISHh4eHkZGZmZeXkpKQkI6Ojo6RkY2Njo6SkpSUkJCQkJGRj4+Ojo2N
jIyMjIuLhoaDg4KCgIB7e3h4dnZ0dG5uYmJZWVFRQkJ8fK+vgoKOjrW1vLyQkH5+eXlra29v
X19ZWWtrjY2OjoWFl5ekpJqah4eAgHh4cnJsbGVla2t7e4WFg4OLi5aWlJSKioODhoaHh4CA
eXl/f4qKioqFhYmJjo6NjYaGgICBgYKCfHx1dXd3enp2dnFxcHBvb2lpX19UVElJPj5dXZqa
jIx9fZ+ftbWbm3R0b29lZWRkXFxSUlxce3uPj4aGiYmZmZmZhYV0dG1taGhlZWFhYmJwcIGB
hoaFhYyMj4+IiHt7dHR0dHNze3t/f4KCi4uQkIuLg4OFhYKCeXl2dnl5e3t7e3p6dnZ2dnd3
cXFoaGZmZGRYWEpKPj4/P3JypqaGhoCArKyzs4iIZGRmZl1dXV1YWFJSZmaKipiYiYmOjpqa
kZF3d2lpY2NgYGNjZGRqant7jY2OjoqKjIyKin5+cXFubm1tdHSEhIWFiYmVlZaWh4eAgIGB
fHx2dnV1eXl/f4ODfX13d3p6eXltbWZmZ2diYlZWRkY9PVFRk5OoqH9/kJC0tKiodXVfX2Bg
XFxjY1tbXV15eZ2dnJyNjZGRlZWGhm9vY2NeXmVlbGxvb3d3ioqXl5KSjIyJiYKCdnZtbWtr
fX2OjoiIiYmXl5qaiop/f319f3+BgXp6eHiEhIyMgYF3d3l5e3tycmhoZ2dlZV5eTk4+PlBQ
nJywsIODjo6vr6ureXlhYVlZX19tbWVlYmJ8fKSko6ORkY6Oj4+FhXNzZGRcXGlpd3d6en5+
jo6ampaWjY2EhH19dnZ0dHFxdnaGhpGRnZ2YmJaWkpKLi3x8d3d8fH19gYGFhYqKi4uJiX5+
d3d3d3JyampmZmZmXFxNTUFBYWGtramphoaYmK6un590dF9fU1NmZnR0aGhqaoqKqKigoJOT
jIyHh35+cnJjY19fcXF9fYCAh4eTk5eXk5OLi39/d3d1dXJydnaHh5GRmJiampiYkpKLi4CA
d3d9fYKCg4OFhYuLjY2JiYCAeHh2dnd3cXFra2trZ2daWk9PQ0N1dbW1mZmLi5ubqamOjnV1
Xl5UVHFxd3dsbHFxlZWhoZiYjo6FhX9/e3t0dGRkaWl5eYGBg4OLi5GRj4+OjoaGe3t3d3h4
dXV8fJiYnJySkpOTlpaLi4GBenp2doODi4uFhYODjo6MjICAd3d0dHZ2dnZwcGpqampnZ1tb
TExHR4eHqKiQkJCQnZ2enoaGeHhaWl5ednZ2dmxse3uUlJaWk5OKioCAfHx9fXNzaWlzc3x8
gYGFhYyMi4uLi4uLg4N9fX19h4eQkIyMioqNjY2Nh4eDg4KChYWIiIiIhYWGhoiIgYF6enl5
e3t5eXd3dXVzc3Bwa2tiYl1dU1NQUIKCmJiSkpSUnp6VlYeHenphYWVldXV2dnFxgoKOjpCQ
kJCJiX9/fX1+fnR0cnJ5eX19gICGhomJioqMjJCQlZWRkYmJhISFhYODgoKDg4aGjIyQkI2N
iYmIiIWFgIB9fXp6enp8fH5+e3t5eXh4c3Nubm1taWlnZ2FhaGiDg5CQjo6MjI2NiIiDg3d3
bm51dYCAf39/f4WFiYmJiYWFf398fH9/f399fXx8gICCgoODhISKio+PjIyIiIiIi4uJiYWF
goKGhouLi4uHh4eHioqKioSEgICBgYKCgYF+fnx8f3+BgXt7eHh5eXl5d3d0dHJycXFvb2lp
a2t3d3x8f3+CgoaGhoaGhoCAfHx9fX5+fHx9fYCAhISHh4WFg4OEhIaGhISDg4KCh4eLi4mJ
hoaFhYiIiIiGhoSEh4eKioyMioqIiIeHhoaEhIKCgoKDg4SEg4ODg4KCgYF/f319fHx7e3t7
e3t6enp6e3t5eXV1dXV1dXZ2eXl8fH5+goKFhYSEg4OBgYCAf39/f35+gICCgoSEhYWFhYSE
hISFhYWFhYWIiIeHh4eIiIeHhYWIiIeHh4eKiouLiYmKiomJh4eHh4aGg4OEhIWFg4ODg4OD
g4ODg4ODgIB/f4CAf39/f4CAf3+AgICAfn59fX5+fHx8fH19fX1+fn9/fn5+fn5+fX1/f4KC
goKBgYKCg4OEhISEgoKDg4WFhYWEhIaGh4eIiIqKiYmHh4iIh4eFhYWFhYWFhYaGhoaFhYWF
hYWDg4KCgYGAgICAgICAgH5+fn5+fn5+fX19fX19f39/f319fHx8fHt7eXl4eHl5eXl4eHh4
d3d3d3V1dXVzc3NzdHR0dHJyc3Nzc3JycXFvb25ub29vb25ubW1tbW1ta2toaGhoaGhnZ2Vl
ZGRjY2NjYWFfX15eXV1eXlxcW1tbW1tbXFxaWlhYWVlaWlhYV1dWVllZWVlbW1lZXFxcXF5e
XFxcXFxcXV1fX15eX19fX2BgYGBfX1xcYGBgYF9fXV1hYWFhY2NgYGNjZGRoaGRkZWVnZ2lp
Z2dpaWdnampra2lpampubm5ubm5ubm9vcXFzc3BwcXF1dXR0dHR2dnd3eHh4eHZ2d3d5eXl5
eXl4eHh4eHh7e3h4enp6en5+enp9fXp6fX18fH5+fHx/f35+fn5/f39/gICBgYKCgYGDg4OD
hISDg4aGhYWHh4eHhoaHh4iIiIiKioqKi4uMjIyMjIyOjo2NkJCOjpCQjo6QkI6Oj4+OjpCQ
kJCSkpCQlJSSkpWVkpKTk5KSk5OSkpOTk5OTk5KSlJSSkpKSkpKRkZKSkpKSkpSUk5OSkpOT
kpKTk5OTlJSRkZWVkpKSkpKSk5ORkZKSkpKSkpSUk5ORkZOTk5OSkpOTk5OTk5WVk5OUlJSU
lZWTk5SUkpKTk5OTkpKSkpKSkpKSkpKSk5OSkpOTkpKSkpGRk5ORkZGRk5OTk5OTkpKSkpGR
k5OQkJGRjo6RkZCQkJCOjpCQjY2NjY2Njo6MjI+PjY2Ojo2NjY2Li46OjIyOjoyMjY2Kio6O
iYmNjYuLjY2MjI2NjIyOjo2NjY2OjoyMjY2NjYyMi4uNjYuLi4uMjIuLjIyLi4uLi4uKiouL
iYmMjImJjIyJiYuLioqLi4qKiYmKiomJioqJiYqKiYmKioiIioqIiImJiYmKiomJioqJiYqK
iYmIiImJiIiJiYeHiIiGhomJhoaKioaGioqGhouLhoaJiYeHioqGhomJh4eJiYiIiIiHh4iI
iIiHh4mJiIiJiYiIioqHh4uLiIiLi4iIi4uHh4yMiIiJiYmJiYmIiImJiIiKioiIiYmJiYmJ
iYmJiYmJiIiKioiIiIiIiImJh4eJiYaGiIiHh4iIh4eIiIaGiYmGhoiIhoaIiIeHiIiFhYeH
h4eFhYaGhYWGhoWFhYWEhIaGhYWEhIODhISDg4SEg4ODg4SEg4ODg4ODg4OEhIODg4OCgoOD
g4ODg4KChISCgoKCgYGCgoGBg4OBgYGBgoKAgIGBgICAgIGBgYGAgIGBgICAgICAgICBgYGB
gIB/f4GBgICAgIGBf3+AgICAgIB/f4CAgICAgH5+gIB+fn9/fn6AgH9/gYF+foCAf39/f35+
fn5+fn9/fn5/f319gIB9fX9/fX1+fn19fn59fX5+fn5+fn19fX1+fn5+fX1/f319f398fH19
fn59fX5+fHx9fXx8fn58fH5+fHx9fXx8fX19fX19fX19fX5+fX19fX19fn59fX5+fHx/f3x8
fn58fH19fHx+fnt7fn56en5+e3t8fHt7fX17e319fHx+fnt7fX17e3x8e3t8fHt7fHx6enx8
e3t8fHt7fX16en19enp8fHt7fHx8fHp6fHx6enx8enp8fHp6enp7e3l5e3t5eXx8eXl8fHl5
e3t6ent7eXl8fHl5fHx6ent7e3t6ent7enp5eXt7eHh8fHl5e3t5eXt7eXl7e3l5e3t5eXl5
e3t6enl5e3t4eHt7eXl7e3l5enp6enl5enp4eHt7d3d7e3h4enp6enh4eXl7e3h4fHx3d3t7
eHh6enl5eHh7e3h4e3t4eHh4fHx3d3t7dnZ+fnZ2fHx4eHp6enp5eXp6eHh8fHh4enp6enh4
fHx3d3t7eHh6enp6eHh7e3d3e3t4eHl5eXl5eXp6dnZ9fXV1e3t4eHh4e3t2dnx8dXV8fHZ2
enp3d3p6d3d7e3V1fX10dICAcnJ/f3V1e3t5eXZ2fn5zc4CAc3N/f3Z2enp8fHZ2f391dX5+
dnZ9fXh4enp7e3l5enp7e3p6enp7e3p6enp7e3p6e3t7e3t7e3t7e3t7enp8fHp6fHx6enx8
e3t7e3x8e3t8fHp6fHx7e3x8e3t8fHx8e3t8fHt7fX17e319fHx8fHx8fHx8fH19fX19fX19
fX19fX19fX19fX19fX19fX19fX19fX5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn9/f39/f35+fn5/f39/f39+fn9/fn5+fn9/fn5/f35+
f39+fn9/fn5/f35+f39/f35+f39+fn5+f39+fn5+f39+fn5+f39+fn9/fn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn9/fn5+fn5+fn5+fn5+fn5+fn9/
fn5+fn5+f39/f35+fn5+fn5+fn5+fn5+f39/f39/fn5+fn9/fn5/f39/f39+fn5+fn5+fn9/
fn5/f35+f39/f35+fn5/f39/f39+fn5+fn5+fn5+fn5+fn9/fn5/f35+fn5+fn9/fn5/f39/
f39/f35+f39+fn9/fn5/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/
f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/
f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/
f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/
f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/
f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/
f39/f39/f39/f39/f39/f39/f39/f39/f3+AgH9/f39/f39/f39/f39/f39/f39/f39/f39/
f39/f39/gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAf3+AgICA
gICAgICAgICAgICAf3+AgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA
gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA
gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA
gICDg4aGfn6CgoWFfn6CgoSEhoaCgoKChISCgoODhISEhIaGhISCgoODgYGDg4ODgICEhIGB
f3+Ghn5+g4OCgn9/hYV+foaGf3+AgIWFfX2CgoCAgoJ/f4SEf399fYiIe3t/f4eHenqBgYiI
dnaGhoSEeXmGhn9/fHyIiHt7gYGCgnx8hoZ8fH9/hoZ6eoODgoJ6eoeHfX19fYiId3eHh4OD
fHyJiX5+hYWAgH9/h4d/f4SEgoKAgIeHfHyDg4SEgICEhIODgICEhIKCgICDg4GBg4N+foOD
gYF/f4SEfHyDg4KCf3+CgoGBgICBgYGBf3+CgoGBgICAgICAgoKAgIGBgICBgYGBf3+BgX9/
gYGBgX9/gYGBgX5+g4N/f39/g4N/f4CAgIB/f4GBf3+AgH9/goKBgX9/g4OAgIODg4N/f4KC
g4OAgICAgICCgoGBgYGAgIGBg4N+foGBgYGBgYGBfn6BgYCAgIB9fX5+g4N+fn5+f39/f4GB
fX19fX9/goJ+fnt7gICAgH9/e3t8fICAf397e3t7gICAgH19e3t/f4GBf398fH19gYGAgHx8
fX2AgIGBf398fH5+goJ/f3x8fX2AgH9/fX18fH5+f399fXt7fX1/f35+fX18fH9/f399fXx8
fn5/f319fX1+fn5+fn59fXx8fn5+fnx8fHx9fX19fHx6enp6e3t7e3h4eXl5eXl5eHh2dnd3
eHh2dnV1dnZ3d3Z2dXV0dHV1dXV0dHNzdXV2dnV1dHR1dXZ2d3d2dnV1dnZ3d3Z2dXV2dnZ2
d3d2dnZ2d3d4eHZ2d3d4eHh4eXl3d3h4enp6enl5eXl6ent7e3t6ent7fHx8fHx8fHx9fX5+
fX18fH19fn59fXx8fX19fX5+fn59fX9/f39+fn9/f39/f39/fn5+fn9/f39+fn5+fn5+fn5+
fn5/f39/f39/f39/gICAgICAf3+AgICAgIB/f39/f39/f39/f39/f4CAf39/f39/f39/f35+
f39/f39/f39/f39/f39/f35+fn5/f35+fn5+fn5+f39/f39/f39/f39/f39/f39/f39/f39/
f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/gICAgICA
gIB/f39/f39/f39/f39/f39/gIB/f4CAgIB/f4CAgICAgICAgICAgICAgICAgICAgYGBgYGB
gYGBgYGBgYGBgYGBgYGBgYKCgYGBgYKCgoKCgoKCgoKDg4ODg4ODg4ODg4ODg4ODg4OEhIOD
g4ODg4ODg4OEhISEhISEhISEhYWEhIWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhoaGhoaG
hoaGhoaGhoaGhoaGhoaGhoaGhoaGhoeHh4eHh4eHh4eHh4eHh4eHh4eHh4eHh4eHh4eHh4iI
iIiIiIiIiIiIiIiIh4eIiIiIiIiIiIeHiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIh4eIiIeH
h4eIiIiIiIiIiIiIiIiIiIiIiIiHh4iIiIiIiIeHh4eHh4eHh4eHh4eHh4eHh4eHh4eHh4eH
h4eHh4eHh4eHh4eHh4eHh4eHh4eHh4eHh4eHh4eHh4eHh4eHh4eHh4eHhoaGhoaGhoaGhoaG
hoaGhoaGhoaGhoaGhoaGhoaGhoaGhoaGhoaGhoaGhoaGhoaGhoaGhoaGhoaGhoaGhYWFhYWF
hYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYSEhISEhISEhISEhISEhISEhISEhISEhISE
hISEhISEhISEhISEg4ODg4ODg4ODg4ODg4ODg4ODg4ODg4ODg4ODg4ODg4ODg4ODg4ODg4OD
goKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGB
gYGBgYGBgYGBgYGBgYGBgYCAgICBgYGBgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA
gICAgICAgICAgICAgIB/f4CAgICAgICAgICAgICAgIB/f39/f39/f39/f39/f39/f39/f39/
f39/f39/f39/f39/f39/f39/f39+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+fn5+fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19
fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19
fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18fHx8fX19fX19fX19fXx8fHx8fHx8
fHx8fHx8fX18fHx8fHx8fHx8fHx8fH19fHx8fHx8fHx8fHx8fHx8fHx8fHx8fHx8fHx8fHx8
fHx8fHx8fX18fHx8fX18fHx8fX19fXx8fHx8fHx8fX18fHx8fHx9fX19fX19fX19fHx9fX19
fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19
fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19
fX19fX19fX1+fn19fX1+fn19fX1+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn9/
fn5+fn5+fn5+fn9/f39+fn9/f39+fn5+f39/f35+fn5+fn5+fn5+fn5+f39+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+
f39/f35+fn5+fn9/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/
f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/
f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/
f3+AgICAgICAgH9/f39/f39/f39/f39/gICAgICAgICAgICAgICAgICAgICAgICAgICAgICA
gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA
gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA
gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA
gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA
gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA
gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA
gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA
gICAgICAgICAgICAgICAgICAgIB/f39/f3+AgICAf3+AgH9/gICAgICAgIB/f39/gICAgICA
f3+AgH9/f39/f39/f39/f39/f39/f39/f3+AgICAf39/f4CAf3+AgICAgICAgICAgICAgH9/
f3+AgH9/f39/f39/f39/f39/f39/f39/gICAgICAgICAgICAgICAgICAgICAgICAgICAgICA
gICAgICAgICAgICAgICAgICAgICAgH9/gICAgICAgICAgICAgICAgICAgICAgICAgICAgICA
gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA
gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA
gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA
gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA
gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA
gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA
gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgH9/f3+AgICA
gICAgICAgICAgICAgICAgH9/f39/f4CAgICAgICAgICAgH9/f39/f4CAf39/f4CAgIB/f39/
f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/
f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/
f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/
f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/
f39/f39/f39/f39/f39/f39/f39/f39/f39/f4CAgIB/f39/f39/f39/f3+AgH9/f39/f4CA
f39/f39/f3+AgICAgICAgICAf3+AgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA
gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA
gICAgICAgYGBgYGBgICAgICAgICAgICAgYGBgYCAgICAgICAgICBgYGBgYGBgYCAgICAgICA
gYGBgYCAgYGBgYGBgYGAgIGBgYGBgYGBgYGBgYGBgICAgICAgICAgICAgYGBgYCAgICAgIGB
gYGBgYGBgYGBgYGBgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA
gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA
gICAgICAgICAgH9/f3+AgH9/gIB/f4CAgICAgICAgICAgICAgICAgICAgICAgH9/f39/f39/
f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/
f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/
f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/
f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f35+f39/f39/f39/f39/
f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39+fn5+fn5+fn9/f39/f39/f39/f39/
f39/f39/fn5+fn5+fn5/f39/f39/f35+fn5+fn9/f39/f39/f39/f39/f39/f35+f39/f39/
f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/
f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f4CAgICAgICA
gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA
gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBgYGBgICBgYGB
gICBgYCAgICBgYGBgYGAgICAgICAgICAgICAgIGBgICBgYGBgYGAgICAgICAgIGBgYGBgYGB
gYGBgYGBgYGAgICAgICAgIGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGAgIGB
gYGAgICAgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYCAgICAgICAgICAgICAgICAgICAgICAgICA
gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA
gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgH9/f3+AgICAgICAgH9/gICAgICA
f39/f4CAgIB/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/
f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/
f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/
f39/f39/f39/f39/f39/f39/fn5/f35+fn5+fn5+fn5+fn5+f39/f39/f39/f39/f39/f39/
f39+fn5+f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/
f39/f39/f39/f39/f39/f39/fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn9/f39/f39/
f39/f39/f39/f39/f39/f4CAgICAgICAgICBgYGBgYGBgYGBgYGBgYGBgYGAgICAgICAgICA
gIB/f39/f39/f39/fn5+fn5+fn59fX19fX19fX19fHx9fX19fX19fX19fn5+fn9/f3+AgIGB
gYGCgoKCg4ODg4SEhISEhISEhISEhISEhISEhISEhISEhISEhISEhIODg4OCgoKCgYGAgH9/
fn58fHt7eXl4eHZ2dHRxcW9vbW1tbW9vc3N4eH9/h4eNjZKSlJSUlJGRjY2Hh4GBfHx4eHZ2
dnZ2dnh4enp7e319fn5/f4CAgoKEhIaGiIiKiouLi4uKioiIhoaDg4KCgYGBgYKChISGhoiI
iYmKioqKiYmJiYeHhoaEhIKCgIB9fXp6d3d0dHBwbW1paWZmZmZoaGxsdHR9fYaGkJCWlpqa
mpqXl5GRioqCgnt7dXVycnFxcnJ0dHZ2eXl7e3x8fn6AgIKChISHh4qKjIyOjo6OjY2KioeH
hISBgYCAgICBgYODhYWHh4mJiYmKiomJiIiHh4WFgoKAgHx8eHh0dHBwampkZGBgXl5fX2Rk
b297e4iIlJScnKGhoaGdnZSUioqAgHd3cXFtbW1tbm5xcXR0d3d5eXt7fX1+foGBhISIiIyM
j4+RkZGRjo6KioWFf397e3l5eXl8fICAhYWJiYyMjo6OjoyMioqHh4WFgoJ/f3x8eHh0dHBw
a2tmZmBgXFxdXV5eZ2dzc4CAjo6amqGhpKSiopqakJCFhXp6cHBra2lpaWlsbHFxdXV4eHt7
fn5/f4KChYWIiIyMkJCRkZGRj4+KioWFf396enh4eHh7e39/hYWKio2Nj4+Pj42Ni4uIiISE
gIB9fXl5dHRxcWxsaGhjY15eW1tcXF9faWl2doODkpKenqWlp6ejo5qajo6AgHR0amplZWRk
ZmZra3Fxd3d8fICAg4OFhYiIioqMjI6OkJCOjoyMiIiDg319eHh2dnZ2eXl/f4WFjY2SkpSU
lZWSko6OiYmEhH9/enp3d3NzcXFvb21tbGxqamZmYmJiYmRkaWl1dYGBjo6bm6OjpaWiopmZ
jIx+fnFxZ2dhYWJiZmZtbXZ2fX2Dg4eHiYmJiYmJiYmJiYmJioqIiIaGg4N/f3x8enp6enx8
gYGHh42NkpKUlJOTkJCLi4aGgYF8fHh4dXVzc3JycnJzc3JycXFubmhoZWVmZmdnb296eoWF
k5OcnKGhoaGbm5CQg4N2dmtrZWVlZWlpb294eICAhoaJiYqKiYmIiIaGhYWEhISEg4OBgYCA
fX17e3t7fX2BgYiIj4+UlJeXlZWRkYyMhYV/f3t7eHh3d3d3eXl6enx8fn5+fn19enp1dW5u
ZWVhYWJiZWVvb3x8iYmWlp6eoaGenpWViYl9fXJya2tpaWxscnJ6eoGBhoaIiIiIh4eEhIOD
goKCgoKCgYGBgYCAf39+foCAg4OHh4uLjo6QkI+PjY2JiYWFgYF/f35+fX1+fn9/gICBgYGB
gIB/f3x8eHh0dG9vampjY2JiZ2dsbHp6h4eSkpycnZ2ZmZGRhYV6enJybGxtbXNzenqDg4mJ
jIyLi4iIg4N+fnt7e3t8fH5+gICBgYGBgoKBgYKChYWJiYyMkJCPj42NioqEhICAfn59fX9/
gYGDg4aGh4eGhoSEgYF9fXl5dnZzc25uaGhiYl1dZGRwcH5+kJCbm6OjoKCTk4SEcnJjY15e
YGBqan19j4+enqWloKCVlYKCcXFmZmNjaWl1dYKCjIyQkJCQjY2JiYWFg4OCgoKCgoKCgoSE
hoaIiIuLjY2OjoyMiIiEhICAfHx6enp6e3t8fHt7eHhycmhoW1tOTlRUaGh8fJ2dqKirq6Ki
gYFsbFZWSUlYWG1th4elpbCwsLCiooeHcXFeXllZZGR1dYqKlpabm5SUhYV6enJydHR9fYSE
ioqLi4iIiYmJiYyMkJCPj42Nh4eAgH19fX2BgYaGiYmHh4KCe3tzc2xsZmZfX1lZTU1QUG9v
gYGhobCwo6OcnHNzWFhSUkhIYWGBgZWVrq6wsKOjk5N2dmdnYGBjY3R0g4OTk5SUkJCIiHx8
fHx9fYODi4uIiIeHgoJ/f4SEiYmSkpWVkZGLi4GBe3t6en19g4OFhYWFf394eHFxaWlmZmBg
VlZJSVpaenqNjbOzqqqcnIaGU1NPT05OWVmHh5ubqamvr5eXh4d1dWdnbm5xcXx8g4OIiIqK
hYWIiIWFg4OFhX19f397e3l5gYGFhZSUm5uZmZOTgoJ6end3fX2KipGRlpaNjYCAdXVtbXJy
d3d7e3t7b29gYEtLODhRUX5+nJzDw66ukZFwcD4+SEhcXHV1oaGnp6CglJR8fHl5e3t+foWF
fHx1dW9vdXWEhJCQnZ2WloaGdHRjY2hoeHiJiZ2dn5+YmI+PfX15eXx8goKOjpOTkpKNjYSE
fn58fHt7fHx+fnt7eHhzc2pqZGRZWUtLSUlwcIuLqam0tI+PgoJZWUpKZWVsbIuLnZ2UlJWV
iYmEhIiIgIB9fXR0bGxwcHt7j4+Xl5qaj496enBwZ2dubnp6h4eYmJWVlJSKioWFhoaAgIaG
hYWHh4+PjY2RkYuLhYV/f3d3eHh5eXx8fn56enR0aWlcXFBQQUFWVoSEmpq6uqOjgIBubkhI
XFx0dH5+mJiRkYuLjY2IiJCQjY1/f3FxZGRpaXl5kZGgoJubj493d2trbGxycoKCiIiLi4uL
h4eLi5CQkJCMjIKCe3t/f4eHk5OYmJKSiIh9fXh4e3t/f4ODgYF6enNzbW1paWNjW1tHR1NT
gYGVlbi4pKR9fW9vSkpfX3l5gYGXl46OiIiMjIyMlJSMjHp6ampiYm5ug4Obm6GhlJSEhHBw
bm50dHx8goJ8fHt7fX2Ghpqan5+amomJcnJzc3t7jY2dnZiYk5OGhoCAhISEhIaGf393d3Z2
d3d9fXx8dXVmZlVVSkpLS3p6mZmqqqmpeHhublxcYmKCgoCAiIiEhIGBkJCVlZmZi4t1dWVl
ZGR2domJmZmYmImJf392dnh4fX17e3p6dHR3d4GBi4uUlJaWjIyCgnt7e3uIiI6OkpKPj4iI
iIiIiIuLioqDg39/e3t9fYCAf397e3NzbGxmZl5eVlZKSmholpamprKyg4NmZmBgWFh+foSE
hYWHh39/kZGXl5iYi4tvb2JiY2N5eY+PmJiXl4aGe3t4eHl5fn55eXV1c3N5eYaGj4+RkYqK
gIB5eXp6gYGMjJWVlJSPj4aGgoKFhYaGiYmHh4aGhoaFhYWFf395eXR0cnJycnFxbm5mZlpa
TExoaJSUoaGqqn19ZWVoaGVlhYWCgnt7gYGBgZmZnJyRkX9/aGhmZnNzhISPj46OiYmEhIGB
gIB+fnd3cXFzc3l5hISKioqKhoZ/f3t7e3t7e4aGk5OUlJSUh4eBgYSEgoKJiYeHiIiMjIuL
jY2EhHx8d3d1dXh4e3t6end3c3Nra2BgUVFUVIKCmZmkpJSUbW1zc29venp/f29venqEhJeX
oaGSkoCAcHBtbXV1fn6CgoWFiIiLi4uLhIR8fHV1cnJ3d3x8gICEhIaGiIiGhoGBfHx4eHp6
goKKio6Ok5OSko+PiYmAgICAgoKHh42NjIyMjIqKhoaCgnl5dHR0dHh4fHx8fHl5dHRra19f
VFRgYIeHmZmfn4mJc3N6end3e3t1dW5uf3+Pj52dmZmIiHx8dnZ3d3h4eHh9fYaGj4+QkIiI
fn55eXl5enp6enp6fX2EhIqKioqFhX19enp7e319gICCgoiIkpKampSUh4d8fHx8hISGhoeH
iIiLi5CQjY2EhHl5dHR2dnl5fHx8fHt7e3t3d3FxZWVcXF5ee3uUlJWVjY16enx8gYF5eXNz
bW15eY2NlpaVlYmJgYF+fnp6dXV0dHh4hISMjI2NhoaAgH5+fX16end3dnZ7e4ODiIiIiIOD
gIB+fn19fHx8fH9/g4OIiI6OkZGNjYmJgoKBgYGBgoKFhYeHi4uMjImJhIR9fXp6eHh3d3l5
e3t9fXx8eHh1dW9vaWlmZmhofHyKioyMiop8fIGBfn53d3V1cnKAgIqKjo6OjoeHhISBgXp6
d3d1dXt7goKFhYeHhISCgoCAfn56end3eHh8fICAg4OEhIODgoKAgH5+fHx8fH5+gYGCgoOD
iIiLi42NioqEhIGBgYGDg4ODg4OFhYeHiIiGhoGBfn58fHp6eHh4eHp6e3t8fHt7dnZzc25u
aWlpaXV1goKFhYeHgICDg4CAe3t4eHV1fHyCgoaGiIiHh4WFhYV/f3x8eHh4eH19f3+BgYGB
gYGBgYCAfn58fHp6enp8fH19fn5/f4CAgYGAgH9/fX19fX9/gIB/f35+gICBgYODhISEhIOD
goKCgoKCgoKCgoKCg4ODg4ODg4OCgoKCgoKBgYCAgICAgICAf39+fn5+fX18fHp6eXl4eHh4
eXl6enp6enp6en19fn5/f39/gICBgYKCg4ODg4ODhISDg4ODg4OCgoKCgYGBgYGBgIB/f39/
fn5+fn5+fn59fX5+fn5+fn5+fn5+fn9/f39/f39/gICAgIGBgYGCgoKCg4OEhISEhISFhYaG
hoaFhYWFhYWFhYWFg4OCgoKCgYGBgYCAf39+fn5+fX18fHt7e3t6enp6eXl4eHd3d3d5eXp6
eXl5eXt7fX1/f39/f3+AgIGBg4ODg4ODg4OEhISEhISDg4ODgoKCgoKCgYGAgICAf39/f35+
fn59fX19fn59fX5+fn5+fn5+f39/f4CAgICAgICAgICBgYGBgoKDg4SEhISEhISEhYWFhYWF
hISEhISEhISDg4KCgoKBgYGBgIB/f39/fn5+fn19fHx8fHt7e3t7e3l5eXl4eHl5e3t7e3p6
e3t9fX5+f39/f4CAgYGCgoKCgoKCgoODg4ODg4KCgoKCgoKCgoKBgYCAgICAgH9/f39+fn5+
fn5+fn5+fn5+fn9/f39/f39/f3+AgICAgYGBgYGBgoKDg4ODg4OEhIWFhYWFhYWFhYWFhYSE
hISDg4ODg4OCgoGBgICAgICAf39+fn5+fX19fX19fHx8fHt7e3t6enl5eXl6enx8e3t7e319
fn5/f39/f3+BgYKCgoKDg4KCg4ODg4ODg4OCgoKCgoKCgoGBgYGBgYCAgICAgH9/f39/f39/
f39/f39/f39/f4CAgICAgICAgYGBgYGBgYGCgoODg4ODg4SEhYWFhYWFhYWFhYWFhYWFhYSE
hISDg4KCgoKBgYGBgIB/f39/fn5+fn19fX18fHx8fHx7e3p6enp6ent7e3t7e3t7fX1+fn9/
f3+AgIGBgoKCgoKCgoKDg4ODg4OCgoKCgoKCgoGBgYGBgYCAgICAgH9/f39/f39/fn5+fn5+
fn5/f39/f39/f4CAgICAgICAgYGBgYGBgoKDg4ODg4OEhISEhISEhISEhISEhIODgoKCgoKC
gYGAgICAf39/f35+fX19fXx8fHx8fHt7e3t6enp6eXl5eXh4eXl6enp6enp7e319fX1+fn5+
f3+AgIGBgYGBgYGBgYGBgYGBgYGBgYCAgIB/f39/f39/f35+fn5+fn19fX19fX19fX19fX19
fX1+fn5+fn5/f39/gICAgIGBgYGCgoKCg4OCgoODg4ODg4ODgoKCgoKCgoKBgYCAgIB/f39/
fn59fX19fX18fHt7e3t7e3p6enp5eXl5eHh4eHh4eXl6enp6e3t8fHx8fX1+fn5+f3+AgICA
gYGBgYGBgYGBgYGBgYGAgICAgIB/f39/f39/f35+fn5+fn19fX19fX19fn5+fn5+fn5/f39/
gICAgIGBgYGBgYKCgoKDg4ODg4ODg4ODg4ODg4KCgoKCgoKCgYGAgICAf39/f35+fX19fX19
fX18fHt7e3t7e3t7enp6enl5eXl5eXp6enp6ent7fX19fX5+fn5/f4CAgYGBgYGBgYGCgoKC
gYGBgYGBgYGBgYCAgICAgICAgIB/f39/f39/f39/f39/f39/gICAgICAgICBgYGBgYGBgYKC
goKDg4ODg4ODg4SEg4ODg4ODg4ODg4ODgoKCgoKCgYGBgYCAf39/f39/fn59fX19fX19fXx8
fHx8fHt7e3t6enp6e3t8fHt7fHx9fX5+f39/f4CAgYGBgYGBgoKCgoKCgoKCgoKCgoKCgoKC
gYGBgYGBgYGBgYGBgYGAgICAgICAgICAgICAgICAgICBgYGBgYGCgoKCgoKCgoODg4ODg4OD
g4ODg4ODg4ODg4ODgoKCgoKCgYGBgYCAgICAgH9/f39+fn5+fX19fXx8fHx7e3t7enp5eXt7
e3t7e3t7fHx9fX5+fn5/f4CAgYGBgYGBgYGCgoKCgoKCgoKCgoKCgoGBgYGBgYGBgYGAgICA
gICAgICAf3+AgICAgICAgICAgICAgIGBgYGBgYKCgoKCgoODg4ODg4ODg4ODg4SEhISDg4OD
goKCgoGBgYGAgICAf39/f35+fn5+fn19fHx7e3t7e3t6enp6eXl5eXp6enp6ent7fHx9fX19
fX1+fn9/gICAgIGBgYGBgYKCgYGCgoGBgYGBgYGBgYGBgYCAgICAgH9/f39/f39/f39/f39/
f39/f39/f3+AgICAgYGBgYGBgYGCgoKCgoKCgoKCg4ODg4KCgoKCgoKCgYGBgYCAgIB/f39/
fn5+fn19fX18fHx8e3t7e3p6enp5eXl5eHh5eXp6enp6ent7fHx9fX19fX1/f39/gICAgICA
gYGBgYGBgYGBgYGBgYGAgIGBgICAgICAgICAgH9/f39/f39/f39/f39/f39/f39/gICAgICA
gYGBgYGBgoKCgoKCg4OCgoODg4ODg4ODgoKCgoKCgYGBgYCAf39/f35+fn59fX19fHx8fHt7
e3t6ent7enp6enl5eXl7e3t7e3t7e319fX1+fn5+fn5/f4CAgICAgICAgYGBgYGBgYGBgYGB
gYGBgYGBgYGAgICAgICAgICAgICAgICAgICAgICAgICBgYGBgYGCgoKCgoKCgoKCgoKDg4OD
g4ODg4ODgoKCgoKCgYGBgYGBgICAgH9/f39+fn5+fX19fX19fHx8fHt7fHx8fHt7e3t8fHx8
fHx8fH19fn5+fn9/f39/f4CAgICBgYGBgYGCgoKCgoKCgoKCgoKBgYGBgYGBgYGBgYGBgYGB
gYGBgYGBgYGBgYKCgoKCgoKCgoKDg4KCg4ODg4ODg4ODg4ODg4OCgoKCgoKCgoGBgYGBgYCA
gICAgH9/fn5+fn5+fn59fX19fX19fX19fX19fX19fX19fX19fX1+fn5+fn5/f39/gICAgICA
gICAgIGBgYGBgYGBgYGBgYGBgYGBgYGBgYGCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKC
goKCgoKCgoKBgYGBgYGBgYGBgICAgICAgIB/f39/f39/f35+fn5+fn5+fX1+fn5+fX19fX19
fX19fX19fX1+fn5+fn5+fn9/f3+AgICAgICAgICAgICBgYGBgYGBgYGBgYGBgYKCgoKCgoKC
goKCgoKCgoKCgoKCgoKCgoKCgYGBgYGBgYGBgYCAgICAgICAf39/f39/f39/f39/fn5+fn5+
fn5+fn19fX19fX5+fX19fX19fX1+fn19fX19fX5+fn5+fn5+fn5+fn9/f39/f39/f39/f39/
f3+AgICAgICAgICAgICBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGAgICAgICAgICA
f39/f39/f39+fn5+fn5+fn5+fX19fX5+fX19fX19fX1+fn5+fn59fX5+fn5+fn19fn5+fn5+
fn5+fn5+fn5+fn5+fn5/f39/f39/f39/f39/f39/f3+AgICAgICAgICAgICAgICAgICAgICA
gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAf39/f39/f39/f35+fn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+fn5+fn5/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/
f39/f39/f39/f39/f39/f39/f39/f4CAf39/f4CAf3+AgICAgICAgICAgICAgICAgICAgICA
gICAgICAf39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f35+f39/f39/
f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/
f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/
f39/f39/f39/f39/f39/f35+fn5/f39/fn5/f39/f39/f39/f39/f39/f39/f39/f39/f39/
f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/
f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/
f39/f39/f39/f39/f39/f39/f39/f39/f3+AgICAf39/f4CAgICAgICAgICAgICAgICAgICA
gICAgICAgIB/f39/f39/f4CAf39/f39/f39/f39/f3+AgICAgICAgICAgICAgICAgICAgICA
gICAgICAgIB/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f4CAgICAgICAgICAgICA
gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAf3+AgICAgICAgICA
gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA
f3+AgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA
gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA
gICAgICAgICAgICAgICAgICAf39/f4CAgICAgICAf3+AgICAf3+AgICAgICAgICAf3+AgICA
f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/
f39/f39/f39/f39/f39/f39/gICAgICAgICAgICAf3+AgICAgIB/f39/f39/f39/f39/f39/
f39/f39/f39/f39/f39/f39/f39/f39/f3+AgICAgICAgICAgICAgICAgICAgICAgICAgICA
gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA
gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA
gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgH9/f39/f39/
f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/
f39/f35+f39/f35+fn5+fn5+fn5+fn5+fn5+fn5+f39/f39/f39/f39/f39/f39/f39/f39/
f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/
f39/f39/f39/f39/f3+AgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA
gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA
gICAgICAgICAgICAgICBgYCAgICBgYGBgICAgICAgICAgICAgICAgICAgYGAgICAgICBgYGB
gYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGB
gYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGB
gYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGB
gYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGB
gYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYKCgoKBgYGBgoKBgYGBgoKCgoKCgYGCgoKC
goKCgoGBgoKCgoKCgoKBgYKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoGB
gYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGB
gYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgICAgICA
gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIB/f39/
f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/fn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn59fX5+fn59fX19fX19fX5+fn5+fn5+
fn5+fn5+fn5+fn5+fX19fX5+fn5+fn19fX1+fn19fX1+fn5+fX1+fn5+fX1+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn9/f39/f39/f39/f35+fn5+fn9/f39/f39/
f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/
f39/f39/f39/f39/f39/f4CAf39/f39/f39/f39/f39/f39/gICAgICAgICAgICAgICAgICA
gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGBgYGBgYGB
gYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGB
gYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGCgoGBgYGBgYGBgYGBgYGBgoKCgoGB
gYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGB
gYGBgYGBgYGBgYGBgYGBgYGBgICBgYCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA
gICAgICAf39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/fn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn59fX19
fX19fX19fX19fX19fX19fX5+fX19fX19fX19fX19fX19fX5+fn5+fn5+fn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+
fn5/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/
f39/f39/f39/f39/f39/f39/gIB/f4CAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA
gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA
gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA
gICAgICAf39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/
f39/f39/f39/f39/f39/f39/f39/f39/f39/f35+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5/f39/f39/f39/f39/f39/f39/f39/f39/f39/
f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/
f3+AgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBgYGB
gYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGB
gYGBgYGBgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKC
goKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKC
goKCgoGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGB
gYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgICAgICAgYGBgYCAgICAgICA
gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA
gICAgICAgICAgICAgICAgICAgIB/f4CAgIB/f39/f39/f39/f39/f39/f3+AgH9/f39/f39/
gIB/f4CAgIB/f4CAf39/f4CAf39/f4CAf39/f4CAf3+AgICAf39/f4CAgIB/f4CAgICAgICA
gICAgICAgICAgICAgICAgICAgICAgH9/gICAgICAgICAgICAgICAgICAgICAgICAgICAgICA
gIB/f4CAgIB/f4CAgICAgICAgIB/f39/f39/f4CAf39/f39/f39/f4CAgICAgH9/f3+AgH9/
f3+AgICAgICAgICAgICAgICAgIB/f4CAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA
gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA
gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA
gICAgICAgICAgICAgICAgICAgICAgH9/gICAgH9/f39/f39/f39/f39/f39/f39/f39/f39/
f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/f39/fn5/f39/fn5/f35+
f39+fn9/fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn19fn59fX5+
fn59fX5+fX19fX5+fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19
fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19
fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn9/f39/f39/f39/f39/
f39/f39/f38=
--------------60713D0015DD8E206BC4D7A4--


