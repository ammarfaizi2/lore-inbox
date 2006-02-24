Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750977AbWBXKlU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750977AbWBXKlU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 05:41:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750979AbWBXKlU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 05:41:20 -0500
Received: from mouth.voxel.net ([69.9.180.118]:43718 "EHLO mail.squishy.cc")
	by vger.kernel.org with ESMTP id S1750964AbWBXKlT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 05:41:19 -0500
Subject: [PATCH] x86_64 stack trace cleanup
From: Andres Salomon <dilinger@debian.org>
To: linux-kernel@vger.kernel.org
Cc: Andi Kleen <ak@suse.de>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-33iowLIuJoBW6/JL9fZ5"
Date: Fri, 24 Feb 2006 05:41:19 -0500
Message-Id: <1140777679.5073.17.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.91 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-33iowLIuJoBW6/JL9fZ5
Content-Type: multipart/mixed; boundary="=-nlZU2b0gpDrJfAdtPS5x"


--=-nlZU2b0gpDrJfAdtPS5x
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi,

This patch cleans up the clutter of x86_64 stack traces, making the
output closer to what i386 and sparc64 stack traces look like.  It uses
print_symbol instead of resolving the symbols manually, and prints one
frame per line instead of displaying multiple frames per line.  I left
the other stuff in the stack dump alone; this affects only the frame
list.

I know this has been brought up before
(http://www.uwsg.iu.edu/hypermail/linux/kernel/0602.0/2238.html,
although I noticed a slight problem w/ that patch, as __print_symbol
returns void); however, for people that don't spend all their time
looking at x86_64 backtraces, I think this consistency shouldn't be
scoffed at.  When you switch back and forth between different archs,
x86_64's backtrace is cluttered and confusing in comparison.

With this patch, traces end up looking as follows:

 getty         S ffff81001e7d1db8     0  3812      1          3814  3811
(NOTLB)
 ffff81001e7d1db8 0000000000000008 ffffffff80240323 0000000000001d93
        ffff81001f82a2d8 ffff81001f82a0c0 ffff81001f68b0c0
0000000000000000
        ffff81001fa841fc ffff81001e7d0000
 Call Trace:
  [<ffffffff80240323>] do_con_write+0x1853/0x1890
  [<ffffffff80164daa>] __pagevec_free+0x2a/0x40
  [<ffffffff802e0e55>] schedule_timeout+0x25/0xd0
  [<ffffffff80134868>] release_console_sem+0x1a8/0x220
  [<ffffffff8014b93c>] add_wait_queue+0x1c/0x60
  [<ffffffff8023441f>] read_chan+0x48f/0x6e2
  [<ffffffff8012e7e0>] default_wake_function+0x0/0x10
  [<ffffffff8022f292>] tty_read+0xa2/0x110
  [<ffffffff80185eff>] vfs_read+0xdf/0x1a0
  [<ffffffff80186b63>] sys_read+0x53/0x90
  [<ffffffff8010afee>] system_call+0x7e/0x83


The old-style trace:

 pdflush       D ffff810037a417a0 0  4293     11          4294  4292
(L-TLB)
 ffff810031fb3d68 0000000000000046 ffff8100107b1d78 0000000000000f60
        0000000000000160 ffff810037a419b8 ffff810037a417a0 f
fff810037a40300
        ffff810001707d80 ffffffff80146b79
 Call Trace:<ffffffff80146b79>{lock_timer_base+41}
<ffffffff8014785d>{__mod_timer+189}
        <ffffffff80154690>{keventd_create_kthread+0}
<ffffffff8030f96a>{schedule_timeout+154}
        <ffffffff80147110>{process_timeout+0}
<ffffffff8030e621>{__sched_text_start+49}
        <ffffffff801fd279>{blk_congestion_wait+153}
<ffffffff80154bc0>{autoremove_wake_function+0}
        <ffffffff801b4051>{writeback_inodes+177}
<ffffffff8016d2d5>{background_writeout+165}
        <ffffffff8016df40>{pdflush+0} <ffffffff8016e095>{pdflush+341}




Signed-off-by: Andres Salomon <dilinger@debian.org>

--=-nlZU2b0gpDrJfAdtPS5x
Content-Disposition: attachment; filename=x86_64-stack-trace.patch
Content-Type: text/x-patch; name=x86_64-stack-trace.patch; charset=UTF-8
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL2FyY2gveDg2XzY0L2tlcm5lbC90cmFwcy5jIGIvYXJjaC94ODZfNjQva2Vy
bmVsL3RyYXBzLmMNCmluZGV4IDI4ZDUwZGMuLjc1OTgxMDcgMTAwNjQ0DQotLS0gYS9hcmNoL3g4
Nl82NC9rZXJuZWwvdHJhcHMuYw0KKysrIGIvYXJjaC94ODZfNjQva2VybmVsL3RyYXBzLmMNCkBA
IC0xNyw2ICsxNyw3IEBADQogI2luY2x1ZGUgPGxpbnV4L2NvbmZpZy5oPg0KICNpbmNsdWRlIDxs
aW51eC9zY2hlZC5oPg0KICNpbmNsdWRlIDxsaW51eC9rZXJuZWwuaD4NCisjaW5jbHVkZSA8bGlu
dXgva2FsbHN5bXMuaD4gDQogI2luY2x1ZGUgPGxpbnV4L3N0cmluZy5oPg0KICNpbmNsdWRlIDxs
aW51eC9lcnJuby5oPg0KICNpbmNsdWRlIDxsaW51eC9wdHJhY2UuaD4NCkBAIC0xMDYsMzAgKzEw
NywxMSBAQCBzdGF0aWMgaW5saW5lIHZvaWQgcHJlZW1wdF9jb25kaXRpb25hbF9jDQogDQogc3Rh
dGljIGludCBrc3RhY2tfZGVwdGhfdG9fcHJpbnQgPSAxMDsNCiANCi0jaWZkZWYgQ09ORklHX0tB
TExTWU1TDQotI2luY2x1ZGUgPGxpbnV4L2thbGxzeW1zLmg+IA0KLWludCBwcmludGtfYWRkcmVz
cyh1bnNpZ25lZCBsb25nIGFkZHJlc3MpDQordm9pZCBwcmludGtfYWRkcmVzcyh1bnNpZ25lZCBs
b25nIGFkZHJlc3MpDQogeyANCi0JdW5zaWduZWQgbG9uZyBvZmZzZXQgPSAwLCBzeW1zaXplOw0K
LQljb25zdCBjaGFyICpzeW1uYW1lOw0KLQljaGFyICptb2RuYW1lOw0KLQljaGFyICpkZWxpbSA9
ICI6IjsgDQotCWNoYXIgbmFtZWJ1ZlsxMjhdOw0KLQ0KLQlzeW1uYW1lID0ga2FsbHN5bXNfbG9v
a3VwKGFkZHJlc3MsICZzeW1zaXplLCAmb2Zmc2V0LCAmbW9kbmFtZSwgbmFtZWJ1Zik7IA0KLQlp
ZiAoIXN5bW5hbWUpIA0KLQkJcmV0dXJuIHByaW50aygiWzwlMDE2bHg+XSIsIGFkZHJlc3MpOw0K
LQlpZiAoIW1vZG5hbWUpIA0KLQkJbW9kbmFtZSA9IGRlbGltID0gIiI7IAkJDQotICAgICAgICBy
ZXR1cm4gcHJpbnRrKCI8JTAxNmx4PnslcyVzJXMlcyUrbGR9IiwNCi0JCSAgICAgIGFkZHJlc3Ms
ZGVsaW0sbW9kbmFtZSxkZWxpbSxzeW1uYW1lLG9mZnNldCk7IA0KKwlwcmludGsoIiBbPCUwMTZs
eD5dICIsIGFkZHJlc3MpOw0KKwlwcmludF9zeW1ib2woIiVzXG4iLCBhZGRyZXNzKTsNCiB9IA0K
LSNlbHNlDQotaW50IHByaW50a19hZGRyZXNzKHVuc2lnbmVkIGxvbmcgYWRkcmVzcykNCi17IA0K
LQlyZXR1cm4gcHJpbnRrKCJbPCUwMTZseD5dIiwgYWRkcmVzcyk7DQotfSANCi0jZW5kaWYNCiAN
CiBzdGF0aWMgdW5zaWduZWQgbG9uZyAqaW5fZXhjZXB0aW9uX3N0YWNrKHVuc2lnbmVkIGNwdSwg
dW5zaWduZWQgbG9uZyBzdGFjaywNCiAJCQkJCXVuc2lnbmVkICp1c2VkcCwgY29uc3QgY2hhciAq
KmlkcCkNCkBAIC0yMDUsMjQgKzE4NywyMyBAQCB2b2lkIHNob3dfdHJhY2UodW5zaWduZWQgbG9u
ZyAqc3RhY2spDQogCXByaW50aygiXG5DYWxsIFRyYWNlOiIpOw0KIA0KICNkZWZpbmUgSEFORExF
X1NUQUNLKGNvbmQpIFwNCi0JZG8gd2hpbGUgKGNvbmQpIHsgXA0KLQkJdW5zaWduZWQgbG9uZyBh
ZGRyID0gKnN0YWNrKys7IFwNCi0JCWlmIChrZXJuZWxfdGV4dF9hZGRyZXNzKGFkZHIpKSB7IFwN
Ci0JCQlpZiAoaSA+IDUwKSB7IFwNCi0JCQkJcHJpbnRrKCJcbiAgICAgICAiKTsgXA0KLQkJCQlp
ID0gMDsgXA0KKwlkbyB7IFwNCisJCWkgPSAwOyBcDQorCQlwcmludGsoIlxuIik7IFwNCisJCXdo
aWxlIChjb25kKSB7IFwNCisJCQl1bnNpZ25lZCBsb25nIGFkZHIgPSAqc3RhY2srKzsgXA0KKwkJ
CWlmIChrZXJuZWxfdGV4dF9hZGRyZXNzKGFkZHIpKSB7IFwNCisJCQkJLyogXA0KKwkJCQkgKiBJ
ZiB0aGUgYWRkcmVzcyBpcyBlaXRoZXIgaW4gdGhlIHRleHQgc2VnbWVudCBcDQorCQkJCSAqIG9m
IHRoZSBrZXJuZWwsIG9yIGluIHRoZSByZWdpb24gd2hpY2ggXA0KKwkJCQkgKiBjb250YWlucyB2
bWFsbG9jJ2VkIG1lbW9yeSwgaXQgKm1heSogYmUgdGhlIFwNCisJCQkJICogYWRkcmVzcyBvZiBh
IGNhbGxpbmcgcm91dGluZTsgaWYgc28sIHByaW50IGl0IFwNCisJCQkJICogc28gdGhhdCBzb21l
b25lIHRyYWNpbmcgZG93biB0aGUgY2F1c2Ugb2YgdGhlIFwNCisJCQkJICogY3Jhc2ggd2lsbCBi
ZSBhYmxlIHRvIGZpZ3VyZSBvdXQgdGhlIGNhbGwgXA0KKwkJCQkgKiBwYXRoIHRoYXQgd2FzIHRh
a2VuLiBcDQorCQkJCSAqLyBcDQorCQkJCXByaW50a19hZGRyZXNzKGFkZHIpOyBcDQogCQkJfSBc
DQotCQkJZWxzZSBcDQotCQkJCWkgKz0gcHJpbnRrKCIgIik7IFwNCi0JCQkvKiBcDQotCQkJICog
SWYgdGhlIGFkZHJlc3MgaXMgZWl0aGVyIGluIHRoZSB0ZXh0IHNlZ21lbnQgb2YgdGhlIFwNCi0J
CQkgKiBrZXJuZWwsIG9yIGluIHRoZSByZWdpb24gd2hpY2ggY29udGFpbnMgdm1hbGxvYydlZCBc
DQotCQkJICogbWVtb3J5LCBpdCAqbWF5KiBiZSB0aGUgYWRkcmVzcyBvZiBhIGNhbGxpbmcgXA0K
LQkJCSAqIHJvdXRpbmU7IGlmIHNvLCBwcmludCBpdCBzbyB0aGF0IHNvbWVvbmUgdHJhY2luZyBc
DQotCQkJICogZG93biB0aGUgY2F1c2Ugb2YgdGhlIGNyYXNoIHdpbGwgYmUgYWJsZSB0byBmaWd1
cmUgXA0KLQkJCSAqIG91dCB0aGUgY2FsbCBwYXRoIHRoYXQgd2FzIHRha2VuLiBcDQotCQkJICov
IFwNCi0JCQlpICs9IHByaW50a19hZGRyZXNzKGFkZHIpOyBcDQogCQl9IFwNCiAJfSB3aGlsZSAo
MCkNCiANCmRpZmYgLS1naXQgYS9pbmNsdWRlL2FzbS14ODZfNjQva2RlYnVnLmggYi9pbmNsdWRl
L2FzbS14ODZfNjQva2RlYnVnLmgNCmluZGV4IGI5ZWQ0YzAuLjcyZjUyNjEgMTAwNjQ0DQotLS0g
YS9pbmNsdWRlL2FzbS14ODZfNjQva2RlYnVnLmgNCisrKyBiL2luY2x1ZGUvYXNtLXg4Nl82NC9r
ZGVidWcuaA0KQEAgLTQ4LDcgKzQ4LDcgQEAgc3RhdGljIGlubGluZSBpbnQgbm90aWZ5X2RpZShl
bnVtIGRpZV92YQ0KIAlyZXR1cm4gbm90aWZpZXJfY2FsbF9jaGFpbigmZGllX2NoYWluLCB2YWws
ICZhcmdzKTsgDQogfSANCiANCi1leHRlcm4gaW50IHByaW50a19hZGRyZXNzKHVuc2lnbmVkIGxv
bmcgYWRkcmVzcyk7DQorZXh0ZXJuIHZvaWQgcHJpbnRrX2FkZHJlc3ModW5zaWduZWQgbG9uZyBh
ZGRyZXNzKTsNCiBleHRlcm4gdm9pZCBkaWUoY29uc3QgY2hhciAqLHN0cnVjdCBwdF9yZWdzICos
bG9uZyk7DQogZXh0ZXJuIHZvaWQgX19kaWUoY29uc3QgY2hhciAqLHN0cnVjdCBwdF9yZWdzICos
bG9uZyk7DQogZXh0ZXJuIHZvaWQgc2hvd19yZWdpc3RlcnMoc3RydWN0IHB0X3JlZ3MgKnJlZ3Mp
Ow0K


--=-nlZU2b0gpDrJfAdtPS5x--

--=-33iowLIuJoBW6/JL9fZ5
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.1 (GNU/Linux)

iD8DBQBD/uLOOmXwGc/ULyYRAjy3AJoDhxbvAUaFbNOxGi/1q82wjBhrgACfQ2X3
igzz6q0yMyPAKiJZ1AADYbc=
=T1WK
-----END PGP SIGNATURE-----

--=-33iowLIuJoBW6/JL9fZ5--

