Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270154AbRHRN3l>; Sat, 18 Aug 2001 09:29:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270155AbRHRN3c>; Sat, 18 Aug 2001 09:29:32 -0400
Received: from [62.70.89.10] ([62.70.89.10]:3590 "EHLO elin.scali.no")
	by vger.kernel.org with ESMTP id <S270154AbRHRN3Z>;
	Sat, 18 Aug 2001 09:29:25 -0400
Date: Sat, 18 Aug 2001 15:29:23 +0200 (CEST)
From: Terje Eggestad <te@scali.no>
To: Dave McCracken <dmccr@us.ibm.com>
cc: Andi Kleen <ak@suse.de>, Terje Eggestad <terje.eggestad@scali.no>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] processes with shared vm
In-Reply-To: <6400000.998082950@baldur>
Message-ID: <Pine.LNX.4.30.0108181513070.6444-200000@elin.scali.no>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-99957877-1556444039-998141363=:6444"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---99957877-1556444039-998141363=:6444
Content-Type: TEXT/PLAIN; charset=US-ASCII

On Fri, 17 Aug 2001, Dave McCracken wrote:

> --On Friday, August 17, 2001 22:55:37 +0200 Andi Kleen <ak@suse.de> wrote:
>
> > Even with a tgid you would need some way to avoid its counter wrapping
> > and getting reused.
>
> While in theory the pid that is used for tgid should never die while the
> thread group exists, this case needs to be handled for thread groups in
> general.  The number shouldn't be re-used for a pid as long as it's in use
> as a tgid.

Be careful, I tested by using _clone() dircetly and let a proc A
create two clones B and C.  I then let A die, and B &C's ppid was now 1.
Attaching this code, you may find it useful for your tgid patch.
(this code is pretty unclean, ran into the problem that if A cloned B
and B cloned C, and now B died B remained a zombie and I didn't seem to
be able to catch SIGCHLD in A. (wanted to se C's ppid go to 1), probably
something stupid, just didn't bother to pursue it....)

THeory is correct if every one is using pthreads...
(exactly how many thread libs are ut there.....??)

>
> > Also gtop should display correct results even with the programs
> > that don't use CLONE_THREAD.
>
> Are there any programs that use CLONE_VM and not CLONE_THREAD?

attached program ;-)
Maybe not, but *the kernel allows it*!

>
> Actually I think we should make tgid visible in /proc in general because
> it's a useful thing to know, whether it's the right mechanism for gtop or
> not.  I'll work up a patch.

Looking forward to it!

>
> Dave McCracken
>
> ======================================================================
> Dave McCracken          IBM Linux Base Kernel Team      1-512-838-3059
> dmccr@us.ibm.com                                        T/L   678-3059
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>



TJ

-- 
_________________________________________________________________________

Terje Eggestad                  terje.eggestad@scali.no
Scali Scalable Linux Systems    http://www.scali.com

Olaf Helsets Vei 6              tel:    +47 22 62 89 61 (OFFICE)
P.O.Box 70 Bogerud                      +47 975 31 574  (MOBILE)
N-0621 Oslo                     fax:    +47 22 62 89 51
NORWAY
_________________________________________________________________________

---99957877-1556444039-998141363=:6444
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="clone.c"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.30.0108181529230.6444@elin.scali.no>
Content-Description: 
Content-Disposition: attachment; filename="clone.c"

I2luY2x1ZGUgPHN0ZGlvLmg+DQojaW5jbHVkZSA8c3RkbGliLmg+DQojaW5j
bHVkZSA8dW5pc3RkLmg+DQojaW5jbHVkZSA8ZXJybm8uaD4NCiNpbmNsdWRl
IDxzeXMvdHlwZXMuaD4NCiNpbmNsdWRlIDxzaWduYWwuaD4NCiNpbmNsdWRl
IDxzY2hlZC5oPg0KDQoNCnBpZF90IHBpZDAsIHBpZDEsIHBpZDI7DQpjaGFy
ICogc3RhY2sxLCAqIHN0YWNrMjsNCg0KI2RlZmluZSBTVEFDS1NJWkUgMTAy
NCo4KjQNCg0Kc3RydWN0IHNpZ2NhbGx7DQogIGludCBzaWc7DQogIHBpZF90
IHBpZDsNCn0gc2lnbGlzdFsxMDI0XTsNCmludCBuc2lnID0gMDsNCg0KcHJp
bnRmc2lnbGlzdCgpDQp7DQogIGludCBpOw0KICBmb3IgKGkgPSAwOyBpPCBu
c2lnOyBpKyspIA0KICAgIHByaW50ZigiJWQ6OiAlZDogJWQgJWRcbiIsIGdl
dHBpZCgpLCBpLCBzaWdsaXN0W25zaWddLnBpZCwgc2lnbGlzdFtuc2lnXS5z
aWcpOw0KfTsNCg0Kdm9pZCBzaWdoYW5kKGludCBzaWcpDQp7DQogIHNpZ2xp
c3RbbnNpZ10ucGlkID0gZ2V0cGlkKCk7DQogIHNpZ2xpc3RbbnNpZ10uc2ln
ID0gc2lnOw0KICBuc2lnKys7DQp9DQoNCmludCBjbG9uZTIoKQ0Kew0KDQog
IHBpZDIgPSBnZXRwaWQoKTsNCiAgcHJpbnRmKCJjbG9uZTIgaGFzIHBpZCAl
ZFxuIiwgcGlkMik7DQoNCiAgc2xlZXAoMTAwKTsNCiAgcHJpbnRmc2lnbGlz
dCgpOw0KfTsNCg0KDQppbnQgY2xvbmUxKCkNCnsNCiAgY2hhciAqIHN0YWNr
Ow0KDQogIHBpZDEgPSBnZXRwaWQoKTsNCiAgcHJpbnRmKCJjbG9uZTEgaGFz
IHBpZCAlZFxuIiwgcGlkMSk7DQoNCiAgc2xlZXAoMTApOw0KICBwcmludGZz
aWdsaXN0KCk7DQogIHJldHVybjsNCiAgZXhpdCgwKTsNCn07DQoNCm1haW4o
KQ0Kew0KICBjaGFyICogc3RhY2s7DQogIGludCB4LCByYzsNCiAgcGlkMCA9
IGdldHBpZCgpOw0KICBwcmludGYoImNsb25lMCBoYXMgcGlkICVkXG4iLCBw
aWQwKTsNCg0KICBzaWduYWwoU0lHQ0hMRCwgc2lnaGFuZCk7DQogIHNpZ25h
bChTSUdBTFJNLCBzaWdoYW5kKTsNCiAgc3RhY2sxID0gbWFsbG9jKFNUQUNL
U0laRSk7DQogIHN0YWNrMiA9IG1hbGxvYyhTVEFDS1NJWkUpOw0KICBzdGFj
azEgKz0gU1RBQ0tTSVpFOw0KICBzdGFjazIgKz0gU1RBQ0tTSVpFOw0KICBw
aWQxID0gX19jbG9uZShjbG9uZTEsIHN0YWNrMSwgQ0xPTkVfVk18Q0xPTkVf
RlN8Q0xPTkVfRklMRVN8Q0xPTkVfU0lHSEFORCwgTlVMTCk7DQogIHBpZDIg
PSBfX2Nsb25lKGNsb25lMiwgc3RhY2syLCBDTE9ORV9WTXxDTE9ORV9GU3xD
TE9ORV9GSUxFU3xDTE9ORV9TSUdIQU5ELCBOVUxMKTsNCg0KICBzbGVlcCgx
KTsNCiAgcHJpbnRmKCJtYXN0ZXI6IGNsb25lMCBoYXMgcGlkICVkXG4iLCBw
aWQwKTsNCiAgcHJpbnRmKCJtYXN0ZXI6IGNsb25lMSBoYXMgcGlkICVkXG4i
LCBwaWQxKTsNCiAgcHJpbnRmKCJtYXN0ZXI6IGNsb25lMiBoYXMgcGlkICVk
XG4iLCBwaWQyKTsNCg0KICBleGl0KDIpOw0KDQoNCn07DQogIA0K
---99957877-1556444039-998141363=:6444--
