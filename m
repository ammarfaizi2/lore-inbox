Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136097AbRECDtD>; Wed, 2 May 2001 23:49:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136094AbRECDsx>; Wed, 2 May 2001 23:48:53 -0400
Received: from cr845378-a.rchrd1.on.wave.home.com ([24.157.76.7]:29304 "EHLO
	mielke.cc") by vger.kernel.org with ESMTP id <S136084AbRECDsr>;
	Wed, 2 May 2001 23:48:47 -0400
Date: Wed, 2 May 2001 23:15:35 -0400 (EDT)
From: Dave Mielke <dave@mielke.cc>
To: "Linux Kernel (mailing list)" <linux-kernel@vger.rutgers.edu>
Subject: Swap space deallocation speed.
Message-ID: <Pine.LNX.4.30.0105022257040.22875-200000@dave.private.mielke.cc>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463811584-1375844607-988859735=:22875"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

---1463811584-1375844607-988859735=:22875
Content-Type: TEXT/PLAIN; charset=US-ASCII

Ever since I've upgraded to the 2.2.17-14 i386 kernel as provided by RedHat,
I've had several hard crashes. One allowed "/var/log/messages" to be synced, so
I was able to capture those details (which are attached to this message as the
file "crash.log"). Once, instead of crashing, the system stayed up but all of
the respawn processes in "/etc/inittab" began to respawn to rapidly, I couldn't
create a shell process to poke around, and the keyboard eventually became
unresponsive. The relevant line in the log, as you can find in the attached
"crash.log" file, appears to be:

    Unable to handle kernel paging request at virtual address 00020024

My guess is that, for whatever reason, I may now be running out of swap space
fairly often. If this is true, then either my children have altered their usage
habits around the same time that I upgraded the kernel, or something about swap
space management has changed between the 2.2.16-3 and 2.2.17-14 kernels. To
this end, I've asked my children to be careful about not opening too many
windows at the same time, and the system now stays up longer but still, on
occasion, without requesting my permission, still goes down hard.

I've also been watching the amount of available swap space with the "free"
command. It predictably goes down quite quickly when a hog like netscape is
started, but, when that same application exits, the available swap space goes
back up very slowly. This would seem to make it very easy to inadvertently run
out of swap space, i.e. quitting and restarting an application still, without
the user realizing it, appears to be a bad thing to do because of the as yet
unreclaimed swap space which is still being counted.

Do any of you have any ideas? If I'm right about the slow reclamation of the
swap space, is there anything I can do, e.g. alter something in "/proc", to
speed up swap space reclamation?

Thanks.

-- 
Dave Mielke           | 2213 Fox Crescent | I believe that the Bible is the
Phone: 1-613-726-0014 | Ottawa, Ontario   | Word of God. Please contact me
EMail: dave@mielke.cc | Canada  K2A 1H7   | if you're concerned about Hell.

---1463811584-1375844607-988859735=:22875
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="crash.log"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.30.0105022315350.22875@dave.private.mielke.cc>
Content-Description: 
Content-Disposition: attachment; filename="crash.log"

QXByIDE2IDExOjIzOjA2IGRhdmUga2VybmVsOiBVbmFibGUgdG8gaGFuZGxl
IGtlcm5lbCBwYWdpbmcgcmVxdWVzdCBhdCB2aXJ0dWFsIGFkZHJlc3MgMDAw
MjAwMjQgDQpBcHIgMTYgMTE6MjM6MDYgZGF2ZSBrZXJuZWw6IGN1cnJlbnQt
PnRzcy5jcjMgPSAwMDEwMTAwMCwgJSVjcjMgPSAwMDEwMTAwMCANCkFwciAx
NiAxMToyMzowNiBkYXZlIGtlcm5lbDogKnBkZSA9IDAwMDAwMDAwIA0KQXBy
IDE2IDExOjIzOjA2IGRhdmUga2VybmVsOiBPb3BzOiAwMDAwIA0KQXByIDE2
IDExOjIzOjA2IGRhdmUga2VybmVsOiBDUFU6ICAgIDAgDQpBcHIgMTYgMTE6
MjM6MDYgZGF2ZSBrZXJuZWw6IEVJUDogICAgMDAxMDpbbG9ja3NfcmVtb3Zl
X3Bvc2l4KzQzLzE0MF0gDQpBcHIgMTYgMTE6MjM6MDYgZGF2ZSBrZXJuZWw6
IEVGTEFHUzogMDAwMTAyMDYgDQpBcHIgMTYgMTE6MjM6MDYgZGF2ZSBrZXJu
ZWw6IGVheDogYzNlNmE2ZDAgICBlYng6IGMwM2U1YzcwICAgZWN4OiBjM2U2
YTY2MCAgIGVkeDogYzAzZTVjNzAgDQpBcHIgMTYgMTE6MjM6MDYgZGF2ZSBr
ZXJuZWw6IGVzaTogMDAwMjAwMDAgICBlZGk6IGMxNGZmNWQwICAgZWJwOiBj
M2U2YTZkMCAgIGVzcDogYzE0MmZmMzAgDQpBcHIgMTYgMTE6MjM6MDYgZGF2
ZSBrZXJuZWw6IGRzOiAwMDE4ICAgZXM6IDAwMTggICBzczogMDAxOCANCkFw
ciAxNiAxMToyMzowNiBkYXZlIGtlcm5lbDogUHJvY2VzcyBwcHAtd2F0Y2gg
KHBpZDogNzUyOCwgcHJvY2VzcyBucjogODEsIHN0YWNrcGFnZT1jMTQyZjAw
MCkgDQpBcHIgMTYgMTE6MjM6MDYgZGF2ZSBrZXJuZWw6IFN0YWNrOiBjMTRm
ZjVkMCAwMDAwMDAwMSBjM2U2YTZkMCBjM2U2YTY2MCAwMDAwMDAwMSBjMDEx
YzlhMSAwMDAwMDAxOSAwMDAwMDAzMiAgDQpBcHIgMTYgMTE6MjM6MDYgZGF2
ZSBrZXJuZWw6ICAgICAgICBjMDExY2E0MCAwMDAwMDAwMCBiZmZmYzAwMCBj
MTUxNDdjMCAwMDAwMDI4NiBjMTUxNDdjMCAwMDAwMWQwMCAwMDAwMDAxZCAg
DQpBcHIgMTYgMTE6MjM6MDYgZGF2ZSBrZXJuZWw6ICAgICAgICBiZmZmZmQ2
OCBjMTUxNDgzYyAwMDAwMWQwMCBjMDEyNzY4YSBjMDNlNWM3MCBjMjAzYTI4
MCAwMDEwMDA0NyAwMDAwMDAwMSAgDQpBcHIgMTYgMTE6MjM6MDYgZGF2ZSBr
ZXJuZWw6IENhbGwgVHJhY2U6IFtjaGVja19wZ3RfY2FjaGUrMTcvMjRdIFtj
bGVhcl9wYWdlX3RhYmxlcysxNTIvMTYwXSBbZmlscF9jbG9zZSs3MC84OF0g
W2RvX2V4aXQrMjkzLzYyNF0gW3N5c19leGl0KzE0LzE2XSBbc3lzdGVtX2Nh
bGwrNTIvNTZdICANCkFwciAxNiAxMToyMzowNiBkYXZlIGtlcm5lbDogQ29k
ZTogZjYgNDYgMjQgMDEgNzQgNDkgOGIgNGMgMjQgNWMgMzkgNGUgMTQgNzUg
NDAgOGIgNGMgMjQgNTggOGIgIA0K
---1463811584-1375844607-988859735=:22875--

