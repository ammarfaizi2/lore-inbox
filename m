Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272923AbTHFW2b (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 18:28:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274804AbTHFW2a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 18:28:30 -0400
Received: from kknd.mweb.co.za ([196.2.45.79]:20096 "EHLO kknd.mweb.co.za")
	by vger.kernel.org with ESMTP id S272923AbTHFW1q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 18:27:46 -0400
Subject: RE: [2.6] Perl weirdness with ext3 and HTREE
From: Martin Schlemmer <azarah@gentoo.org>
Reply-To: azarah@gentoo.org
To: Christopher Li <chrisl@vmware.com>
Cc: KML <linux-kernel@vger.kernel.org>, akpm@digeo.com, adilger@clusterfs.com,
       ext3-users@redhat.com, x86-kernel@gentoo.org
In-Reply-To: <68F326C497FDB743B5F844B776C9B146097700@pa-exch4.vmware.com>
References: <68F326C497FDB743B5F844B776C9B146097700@pa-exch4.vmware.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-sS7VnH+9h5AkNLDJGLBc"
Message-Id: <1060208887.12477.31.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 07 Aug 2003 00:28:07 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-sS7VnH+9h5AkNLDJGLBc
Content-Type: multipart/mixed; boundary="=-+T6801hlD5evnhgPljxk"


--=-+T6801hlD5evnhgPljxk
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2003-08-06 at 22:22, Christopher Li wrote:

> > Just grab the perl source, if you want, I can mail you the ebuild that
> > should give some direction in how to compile it, or grab your local
> > .spec, configure it (maybe with install location not in /), and then
> > just compile and finally install to a ext3 FS with HTREE enabled.=20
> > Usually over here, it keeps on leaving an invalid entry to
> > ..usr/share/man/man3/Hash::Util.tmp.
> >=20
>=20
> I am running 2.6-test2 kernel. Download the perl 5.8.0 (stable.tar.gz).
> ./Configure --prefix=3D/mnt/hdc3; make; make install.
>=20
> It did not happen for me. Hash::Util.3 was installed correctly.
> (Of course, I did turn on directory index)
>=20
> Can you send me more infomation how you build the perl package
> and install it? I guess I have to do more gentoo like step to duplicate
> it :-)
>=20

I have gotten a few of these while testing:

-----------------------------------------
EXT3-fs warning (device hdc1): ext3_unlink: Deleting nonexistent file
(4759186), 0
Slab corruption: start=3Dcb147184, expend=3Dcb14736f, problemat=3Dcb1471f8
Last user: [<c019ae7f>](ext3_destroy_inode+0x1d/0x21)
Data:
***************************************************************************=
*****************************************F4 F1 15 F6 **********************=
***************************************************************************=
***************************************************************************=
***************************************************************************=
***************************************************************************=
*************************************************A5
Next: 71 F0 2C .7F AE 19 C0 71 F0 2C .********************
slab error in check_poison_obj(): cache `ext3_inode_cache': object was
modified after freeing
Call Trace:
 [<c0141634>] check_poison_obj+0x161/0x1a1
 [<c0143128>] kmem_cache_alloc+0x11f/0x159
 [<c019ae46>] ext3_alloc_inode+0x18/0x34
 [<c019ae46>] ext3_alloc_inode+0x18/0x34
 [<c0171f74>] alloc_inode+0x1c/0x14d
 [<c01729db>] new_inode+0x1a/0xa2
 [<c0192207>] ext3_new_inode+0x41/0x6d8
 [<c014313c>] kmem_cache_alloc+0x133/0x159
 [<c01a0244>] new_handle+0x1c/0x4e
 [<c01992e4>] ext3_mkdir+0x74/0x2b6
 [<c01665dc>] permission+0x2f/0x4b
 [<c0168555>] vfs_mkdir+0x6d/0xbf
 [<c016865e>] sys_mkdir+0xb7/0xf7
 [<c010aaa5>] sysenter_past_esp+0x52/0x71
 =20
-----------------------------------------

A more complete one is attached (just more similar ones).

Attached is a script (test.sh) and a list of man page names (list) that
I can recreate it without needing perl.  The list may or may not be
pruned some more, but I will try tonight again after some sleep ;)

Here is a test run (note that it do the same with symlinks instead of
hard links):

-----------------------------------------
nosferatu space # uname -a
Linux nosferatu 2.6.0-test2-bk5 #2 SMP Wed Aug 6 00:21:15 SAST 2003 i686
Intel(R) Pentium(R) 4 CPU 2.40GHz GenuineIntel GNU/Linux
nosferatu space # dumpe2fs /dev/hdc1 | grep features
dumpe2fs 1.34 (25-Jul-2003)
Filesystem features:      has_journal dir_index filetype needs_recovery
sparse_super large_file
nosferatu space # pwd
/space
nosferatu space # mount | grep `pwd`
/dev/hdc1 on /space type ext3 (rw,noatime)
nosferatu space # ls foo/
ls: foo/: No such file or directory
nosferatu space # cat test.sh
#!/bin/bash
=20
i=3D1
=20
testdir=3D"`pwd`/foo"
=20
(rm -rf "$testdir"; rm -rf "$testdir") &>/dev/null
mkdir -p "$testdir"
=20
for x in $(cat list)
do
        temp=3D"$testdir/${x/3pm/tmp}"
        x=3D"$testdir/${x}"
=20
        touch "$temp"
        ln "$temp" "$x"
        rm -f "$temp"
=20
#       echo "Pass $i"
=20
#       i=3D$((i+1))
done
=20
nosferatu space # ./test.sh
nosferatu space # ls foo/
ls: foo/Win32.tmp: No such file or directory
Fcntl.3pm                    PerlIO::via.3pm
Hash::Util.3pm               PerlIO::via::QuotedPrint.3pm
I18N::Collate.3pm            Pod::Checker.3pm
I18N::LangTags.3pm           Pod::Find.3pm
I18N::LangTags::List.3pm     Pod::Html.3pm
I18N::Langinfo.3pm           Pod::InputObjects.3pm
IO.3pm                       Pod::LaTeX.3pm
IO::Dir.3pm                  Pod::Man.3pm
IO::File.3pm                 Pod::ParseLink.3pm
IO::Handle.3pm               Pod::ParseUtils.3pm
IO::Pipe.3pm                 Pod::Parser.3pm
IO::Poll.3pm                 Pod::Plainer.3pm
IO::Seekable.3pm             Pod::Select.3pm
IO::Select.3pm               Pod::Text.3pm
IO::Socket.3pm               Pod::Text::Color.3pm
IO::Socket::INET.3pm         Pod::Text::Overstrike.3pm
IO::Socket::UNIX.3pm         Pod::Text::Termcap.3pm
IPC::Msg.3pm                 Pod::Usage.3pm
IPC::Open2.3pm               SDBM_File.3pm
IPC::Open3.3pm               Safe.3pm
IPC::Semaphore.3pm           Scalar::Util.3pm
IPC::SysV.3pm                Search::Dict.3pm
List::Util.3pm               SelectSaver.3pm
Locale::Constants.3pm        SelfLoader.3pm
Locale::Country.3pm          Shell.3pm
Locale::Currency.3pm         Socket.3pm
Locale::Language.3pm         Storable.3pm
Locale::Maketext.3pm         Switch.3pm
Locale::Maketext::TPJ13.3pm  Symbol.3pm
Locale::Script.3pm           Sys::Hostname.3pm
MIME::Base64.3pm             Sys::Syslog.3pm
MIME::QuotedPrint.3pm        Term::ANSIColor.3pm
Math::BigFloat.3pm           Term::Cap.3pm
Math::BigFloat::Trace.3pm    Term::Complete.3pm
Math::BigInt.3pm             Term::ReadLine.3pm
Math::BigInt::Calc.3pm       Test.3pm
Math::BigInt::Trace.3pm      Test::Builder.3pm
Math::BigRat.3pm             Test::Harness.3pm
Math::Complex.3pm            Test::Harness::Assert.3pm
Math::Trig.3pm               Test::Harness::Iterator.3pm
Memoize.3pm                  Test::Harness::Straps.3pm
Memoize::AnyDBM_File.3pm     Test::More.3pm
Memoize::Expire.3pm          Test::Simple.3pm
Memoize::ExpireFile.3pm      Test::Tutorial.3pm
Memoize::ExpireTest.3pm      Text::Abbrev.3pm
Memoize::NDBM_File.3pm       Text::Balanced.3pm
Memoize::SDBM_File.3pm       Text::ParseWords.3pm
Memoize::Storable.3pm        Text::Soundex.3pm
NDBM_File.3pm                Text::Tabs.3pm
NEXT.3pm                     Text::Wrap.3pm
Net::Cmd.3pm                 Thread.3pm
Net::Config.3pm              Thread::Queue.3pm
Net::Domain.3pm              Thread::Semaphore.3pm
Net::FTP.3pm                 Tie::Array.3pm
Net::FTP::A.3pm              Tie::File.3pm
Net::FTP::E.3pm              Tie::Handle.3pm
Net::FTP::I.3pm              Tie::Hash.3pm
Net::FTP::L.3pm              Tie::Memoize.3pm
Net::FTP::dataconn.3pm       Tie::RefHash.3pm
Net::NNTP.3pm                Tie::Scalar.3pm
Net::Netrc.3pm               Tie::SubstrHash.3pm
Net::POP3.3pm                Time::HiRes.3pm
Net::Ping.3pm                Time::Local.3pm
Net::SMTP.3pm                Time::gmtime.3pm
Net::Time.3pm                Time::localtime.3pm
Net::hostent.3pm             Time::tm.3pm
Net::libnetFAQ.3pm           UNIVERSAL.3pm
Net::netent.3pm              Unicode::Collate.3pm
Net::protoent.3pm            Unicode::Normalize.3pm
Net::servent.3pm             Unicode::UCD.3pm
O.3pm                        User::grent.3pm
Opcode.3pm                   User::pwent.3pm
POSIX.3pm                    Win32.3pm
PerlIO.3pm                   XS::APItest.3pm
PerlIO::encoding.3pm         XS::Typemap.3pm
PerlIO::scalar.3pm           XSLoader.3pm
nosferatu space #
----------------------------------


Thanks,

--=20

Martin Schlemmer




--=-+T6801hlD5evnhgPljxk
Content-Disposition: attachment; filename=log.txt
Content-Type: text/plain; name=log.txt; charset=iso-8859-1
Content-Transfer-Encoding: base64

a2pvdXJuYWxkIHN0YXJ0aW5nLiAgQ29tbWl0IGludGVydmFsIDUgc2Vjb25kcw0KRVhUMyBGUyBv
biBoZGMxLCBpbnRlcm5hbCBqb3VybmFsDQpFWFQzLWZzOiBtb3VudGVkIGZpbGVzeXN0ZW0gd2l0
aCBvcmRlcmVkIGRhdGEgbW9kZS4NCkVYVDMtZnMgd2FybmluZyAoZGV2aWNlIGhkYzEpOiBleHQz
X3VubGluazogRGVsZXRpbmcgbm9uZXhpc3RlbnQgZmlsZSAoMjk2MTQ4NyksIDANCkVYVDMtZnMg
d2FybmluZyAoZGV2aWNlIGhkYzEpOiBleHQzX3VubGluazogRGVsZXRpbmcgbm9uZXhpc3RlbnQg
ZmlsZSAoMjk0NDc0NCksIDANClNsYWIgY29ycnVwdGlvbjogc3RhcnQ9ZDIzMGUxODQsIGV4cGVu
ZD1kMjMwZTM2ZiwgcHJvYmxlbWF0PWQyMzBlMWY4DQpMYXN0IHVzZXI6IFs8YzAxOWFlN2Y+XShl
eHQzX2Rlc3Ryb3lfaW5vZGUrMHgxZC8weDIxKQ0KRGF0YTogKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKiowOCA4OSBBMSBDNiAqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKkE1DQpOZXh0OiA3MSBGMCAyQyAuN0YgQUUgMTkgQzAgNzEg
RjAgMkMgLioqKioqKioqKioqKioqKioqKioqDQpzbGFiIGVycm9yIGluIGNoZWNrX3BvaXNvbl9v
YmooKTogY2FjaGUgYGV4dDNfaW5vZGVfY2FjaGUnOiBvYmplY3Qgd2FzIG1vZGlmaWVkIGFmdGVy
IGZyZWVpbmcNCkNhbGwgVHJhY2U6DQogWzxjMDE0MTYzND5dIGNoZWNrX3BvaXNvbl9vYmorMHgx
NjEvMHgxYTENCiBbPGMwMTQzMTI4Pl0ga21lbV9jYWNoZV9hbGxvYysweDExZi8weDE1OQ0KIFs8
YzAxOWFlNDY+XSBleHQzX2FsbG9jX2lub2RlKzB4MTgvMHgzNA0KIFs8YzAxOWFlNDY+XSBleHQz
X2FsbG9jX2lub2RlKzB4MTgvMHgzNA0KIFs8YzAxNzFmNzQ+XSBhbGxvY19pbm9kZSsweDFjLzB4
MTRkDQogWzxjMDE3MjlkYj5dIG5ld19pbm9kZSsweDFhLzB4YTINCiBbPGMwMTkyMjA3Pl0gZXh0
M19uZXdfaW5vZGUrMHg0MS8weDZkOA0KIFs8YzAxNDMxM2M+XSBrbWVtX2NhY2hlX2FsbG9jKzB4
MTMzLzB4MTU5DQogWzxjMDFhMDI0ND5dIG5ld19oYW5kbGUrMHgxYy8weDRlDQogWzxjMDE5OTE1
ND5dIGV4dDNfY3JlYXRlKzB4NTUvMHhiMA0KIFs8YzAxNjdiZTk+XSB2ZnNfY3JlYXRlKzB4Nzkv
MHhjZQ0KIFs8YzAxNjgxNzk+XSBvcGVuX25hbWVpKzB4MzlhLzB4M2VlDQogWzxjMDE1Nzk3Nj5d
IGZpbHBfb3BlbisweDNlLzB4NjQNCiBbPGMwMTU3ZWRjPl0gc3lzX29wZW4rMHg1Yi8weDhiDQog
WzxjMDEwYWFhNT5dIHN5c2VudGVyX3Bhc3RfZXNwKzB4NTIvMHg3MQ0KIA0KRVhUMy1mcyB3YXJu
aW5nIChkZXZpY2UgaGRjMSk6IGV4dDNfdW5saW5rOiBEZWxldGluZyBub25leGlzdGVudCBmaWxl
ICgyOTQ0NzQ0KSwgMA0KU2xhYiBjb3JydXB0aW9uOiBzdGFydD1lMmI3YzI3YywgZXhwZW5kPWUy
YjdjNDY3LCBwcm9ibGVtYXQ9ZTJiN2MyZjANCkxhc3QgdXNlcjogWzxjMDE5YWU3Zj5dKGV4dDNf
ZGVzdHJveV9pbm9kZSsweDFkLzB4MjEpDQpEYXRhOiAqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKjA4IDg5IEExIEM2ICoqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqQTUNCk5leHQ6IDcxIEYwIDJDIC43RiBBRSAxOSBDMCA3MSBGMCAy
QyAuKioqKioqKioqKioqKioqKioqKioNCnNsYWIgZXJyb3IgaW4gY2hlY2tfcG9pc29uX29iaigp
OiBjYWNoZSBgZXh0M19pbm9kZV9jYWNoZSc6IG9iamVjdCB3YXMgbW9kaWZpZWQgYWZ0ZXIgZnJl
ZWluZw0KQ2FsbCBUcmFjZToNCiBbPGMwMTQxNjM0Pl0gY2hlY2tfcG9pc29uX29iaisweDE2MS8w
eDFhMQ0KIFs8YzAxNDMxMjg+XSBrbWVtX2NhY2hlX2FsbG9jKzB4MTFmLzB4MTU5DQogWzxjMDE5
YWU0Nj5dIGV4dDNfYWxsb2NfaW5vZGUrMHgxOC8weDM0DQogWzxjMDE5YWU0Nj5dIGV4dDNfYWxs
b2NfaW5vZGUrMHgxOC8weDM0DQogWzxjMDE3MWY3ND5dIGFsbG9jX2lub2RlKzB4MWMvMHgxNGQN
CiBbPGMwMTcyOWRiPl0gbmV3X2lub2RlKzB4MWEvMHhhMg0KIFs8YzAxOTIyMDc+XSBleHQzX25l
d19pbm9kZSsweDQxLzB4NmQ4DQogWzxjMDE0MzEzYz5dIGttZW1fY2FjaGVfYWxsb2MrMHgxMzMv
MHgxNTkNCiBbPGMwMWEwMjQ0Pl0gbmV3X2hhbmRsZSsweDFjLzB4NGUNCiBbPGMwMTk5MTU0Pl0g
ZXh0M19jcmVhdGUrMHg1NS8weGIwDQogWzxjMDE2N2JlOT5dIHZmc19jcmVhdGUrMHg3OS8weGNl
DQogWzxjMDE2ODE3OT5dIG9wZW5fbmFtZWkrMHgzOWEvMHgzZWUNCiBbPGMwMTU3OTc2Pl0gZmls
cF9vcGVuKzB4M2UvMHg2NA0KIFs8YzAxNTdlZGM+XSBzeXNfb3BlbisweDViLzB4OGINCiBbPGMw
MTBhYWE1Pl0gc3lzZW50ZXJfcGFzdF9lc3ArMHg1Mi8weDcxDQogDQpFWFQzLWZzIHdhcm5pbmcg
KGRldmljZSBoZGMxKTogZXh0M191bmxpbms6IERlbGV0aW5nIG5vbmV4aXN0ZW50IGZpbGUgKDI5
NDQ3NDQpLCAwDQpTbGFiIGNvcnJ1cHRpb246IHN0YXJ0PWUyYjdjMjdjLCBleHBlbmQ9ZTJiN2M0
NjcsIHByb2JsZW1hdD1lMmI3YzJmMA0KTGFzdCB1c2VyOiBbPGMwMTlhZTdmPl0oZXh0M19kZXN0
cm95X2lub2RlKzB4MWQvMHgyMSkNCkRhdGE6ICoqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqNDQgQkQgOEYgRjYgKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKipBNQ0KTmV4dDogNzEgRjAgMkMgLjdGIEFFIDE5IEMwIDcxIEYwIDJDIC4q
KioqKioqKioqKioqKioqKioqKg0Kc2xhYiBlcnJvciBpbiBjaGVja19wb2lzb25fb2JqKCk6IGNh
Y2hlIGBleHQzX2lub2RlX2NhY2hlJzogb2JqZWN0IHdhcyBtb2RpZmllZCBhZnRlciBmcmVlaW5n
DQpDYWxsIFRyYWNlOg0KIFs8YzAxNDE2MzQ+XSBjaGVja19wb2lzb25fb2JqKzB4MTYxLzB4MWEx
DQogWzxjMDE0MzEyOD5dIGttZW1fY2FjaGVfYWxsb2MrMHgxMWYvMHgxNTkNCiBbPGMwMTlhZTQ2
Pl0gZXh0M19hbGxvY19pbm9kZSsweDE4LzB4MzQNCiBbPGMwMTlhZTQ2Pl0gZXh0M19hbGxvY19p
bm9kZSsweDE4LzB4MzQNCiBbPGMwMTcxZjc0Pl0gYWxsb2NfaW5vZGUrMHgxYy8weDE0ZA0KIFs8
YzAxNzI5ZGI+XSBuZXdfaW5vZGUrMHgxYS8weGEyDQogWzxjMDE5MjIwNz5dIGV4dDNfbmV3X2lu
b2RlKzB4NDEvMHg2ZDgNCiBbPGMwMTQzMTNjPl0ga21lbV9jYWNoZV9hbGxvYysweDEzMy8weDE1
OQ0KIFs8YzAxYTAyNDQ+XSBuZXdfaGFuZGxlKzB4MWMvMHg0ZQ0KIFs8YzAxOTkxNTQ+XSBleHQz
X2NyZWF0ZSsweDU1LzB4YjANCiBbPGMwMTY3YmU5Pl0gdmZzX2NyZWF0ZSsweDc5LzB4Y2UNCiBb
PGMwMTY4MTc5Pl0gb3Blbl9uYW1laSsweDM5YS8weDNlZQ0KIFs8YzAxNTc5NzY+XSBmaWxwX29w
ZW4rMHgzZS8weDY0DQogWzxjMDE1N2VkYz5dIHN5c19vcGVuKzB4NWIvMHg4Yg0KIFs8YzAxMGFh
YTU+XSBzeXNlbnRlcl9wYXN0X2VzcCsweDUyLzB4NzENCiANCkVYVDMtZnMgd2FybmluZyAoZGV2
aWNlIGhkYzEpOiBleHQzX3VubGluazogRGVsZXRpbmcgbm9uZXhpc3RlbnQgZmlsZSAoNDc1OTE1
MiksIDANClNsYWIgY29ycnVwdGlvbjogc3RhcnQ9Y2IxNDcxODQsIGV4cGVuZD1jYjE0NzM2Ziwg
cHJvYmxlbWF0PWNiMTQ3MWY4DQpMYXN0IHVzZXI6IFs8YzAxOWFlN2Y+XShleHQzX2Rlc3Ryb3lf
aW5vZGUrMHgxZC8weDIxKQ0KRGF0YTogKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKiowOCA4OSBBMSBDNiAqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKkE1DQpOZXh0OiA3MSBGMCAyQyAuN0YgQUUgMTkgQzAgNzEgRjAgMkMgLioqKioq
KioqKioqKioqKioqKioqDQpzbGFiIGVycm9yIGluIGNoZWNrX3BvaXNvbl9vYmooKTogY2FjaGUg
YGV4dDNfaW5vZGVfY2FjaGUnOiBvYmplY3Qgd2FzIG1vZGlmaWVkIGFmdGVyIGZyZWVpbmcNCkNh
bGwgVHJhY2U6DQogWzxjMDE0MTYzND5dIGNoZWNrX3BvaXNvbl9vYmorMHgxNjEvMHgxYTENCiBb
PGMwMTQzMTI4Pl0ga21lbV9jYWNoZV9hbGxvYysweDExZi8weDE1OQ0KIFs8YzAxOWFlNDY+XSBl
eHQzX2FsbG9jX2lub2RlKzB4MTgvMHgzNA0KIFs8YzAxOWFlNDY+XSBleHQzX2FsbG9jX2lub2Rl
KzB4MTgvMHgzNA0KIFs8YzAxNzFmNzQ+XSBhbGxvY19pbm9kZSsweDFjLzB4MTRkDQogWzxjMDE3
MjlkYj5dIG5ld19pbm9kZSsweDFhLzB4YTINCiBbPGMwMTkyMjA3Pl0gZXh0M19uZXdfaW5vZGUr
MHg0MS8weDZkOA0KIFs8YzAxNDMxM2M+XSBrbWVtX2NhY2hlX2FsbG9jKzB4MTMzLzB4MTU5DQog
WzxjMDFhMDI0ND5dIG5ld19oYW5kbGUrMHgxYy8weDRlDQogWzxjMDE5OTE1ND5dIGV4dDNfY3Jl
YXRlKzB4NTUvMHhiMA0KIFs8YzAxNjdiZTk+XSB2ZnNfY3JlYXRlKzB4NzkvMHhjZQ0KIFs8YzAx
NjgxNzk+XSBvcGVuX25hbWVpKzB4MzlhLzB4M2VlDQogWzxjMDE1Nzk3Nj5dIGZpbHBfb3Blbisw
eDNlLzB4NjQNCiBbPGMwMTU3ZWRjPl0gc3lzX29wZW4rMHg1Yi8weDhiDQogWzxjMDEwYWFhNT5d
IHN5c2VudGVyX3Bhc3RfZXNwKzB4NTIvMHg3MQ0KIA0KRVhUMy1mcyB3YXJuaW5nIChkZXZpY2Ug
aGRjMSk6IGV4dDNfdW5saW5rOiBEZWxldGluZyBub25leGlzdGVudCBmaWxlICg0NzU5MTg2KSwg
MA0KU2xhYiBjb3JydXB0aW9uOiBzdGFydD1jYjE0NzE4NCwgZXhwZW5kPWNiMTQ3MzZmLCBwcm9i
bGVtYXQ9Y2IxNDcxZjgNCkxhc3QgdXNlcjogWzxjMDE5YWU3Zj5dKGV4dDNfZGVzdHJveV9pbm9k
ZSsweDFkLzB4MjEpDQpEYXRhOiAqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKkY0IEYxIDE1IEY2ICoqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqQTUNCk5leHQ6IDcxIEYwIDJDIC43RiBBRSAxOSBDMCA3MSBGMCAyQyAuKioqKioqKioq
KioqKioqKioqKioNCnNsYWIgZXJyb3IgaW4gY2hlY2tfcG9pc29uX29iaigpOiBjYWNoZSBgZXh0
M19pbm9kZV9jYWNoZSc6IG9iamVjdCB3YXMgbW9kaWZpZWQgYWZ0ZXIgZnJlZWluZw0KQ2FsbCBU
cmFjZToNCiBbPGMwMTQxNjM0Pl0gY2hlY2tfcG9pc29uX29iaisweDE2MS8weDFhMQ0KIFs8YzAx
NDMxMjg+XSBrbWVtX2NhY2hlX2FsbG9jKzB4MTFmLzB4MTU5DQogWzxjMDE5YWU0Nj5dIGV4dDNf
YWxsb2NfaW5vZGUrMHgxOC8weDM0DQogWzxjMDE5YWU0Nj5dIGV4dDNfYWxsb2NfaW5vZGUrMHgx
OC8weDM0DQogWzxjMDE3MWY3ND5dIGFsbG9jX2lub2RlKzB4MWMvMHgxNGQNCiBbPGMwMTcyOWRi
Pl0gbmV3X2lub2RlKzB4MWEvMHhhMg0KIFs8YzAxOTIyMDc+XSBleHQzX25ld19pbm9kZSsweDQx
LzB4NmQ4DQogWzxjMDE0MzEzYz5dIGttZW1fY2FjaGVfYWxsb2MrMHgxMzMvMHgxNTkNCiBbPGMw
MWEwMjQ0Pl0gbmV3X2hhbmRsZSsweDFjLzB4NGUNCiBbPGMwMTk5MmU0Pl0gZXh0M19ta2Rpcisw
eDc0LzB4MmI2DQogWzxjMDE2NjVkYz5dIHBlcm1pc3Npb24rMHgyZi8weDRiDQogWzxjMDE2ODU1
NT5dIHZmc19ta2RpcisweDZkLzB4YmYNCiBbPGMwMTY4NjVlPl0gc3lzX21rZGlyKzB4YjcvMHhm
Nw0KIFs8YzAxMGFhYTU+XSBzeXNlbnRlcl9wYXN0X2VzcCsweDUyLzB4NzENCiANCkVYVDMtZnMg
d2FybmluZyAoZGV2aWNlIGhkYzEpOiBleHQzX3VubGluazogRGVsZXRpbmcgbm9uZXhpc3RlbnQg
ZmlsZSAoNDc1OTEyMiksIDANCkVYVDMtZnMgd2FybmluZyAoZGV2aWNlIGhkYzEpOiBleHQzX3Vu
bGluazogRGVsZXRpbmcgbm9uZXhpc3RlbnQgZmlsZSAoNDc1OTE5NCksIDANCkVYVDMtZnMgd2Fy
bmluZyAoZGV2aWNlIGhkYzEpOiBleHQzX3VubGluazogRGVsZXRpbmcgbm9uZXhpc3RlbnQgZmls
ZSAoNDcxMDYzNyksIDANCkVYVDMtZnMgd2FybmluZyAoZGV2aWNlIGhkYzEpOiBleHQzX3VubGlu
azogRGVsZXRpbmcgbm9uZXhpc3RlbnQgZmlsZSAoNDcxMDYzNyksIDANCkVYVDMtZnMgd2Fybmlu
ZyAoZGV2aWNlIGhkYzEpOiBleHQzX3VubGluazogRGVsZXRpbmcgbm9uZXhpc3RlbnQgZmlsZSAo
NDcxMDYzNyksIDANCg0K

--=-+T6801hlD5evnhgPljxk
Content-Disposition: attachment; filename=test.sh
Content-Type: text/x-sh; name=test.sh; charset=iso-8859-1
Content-Transfer-Encoding: base64

IyEvYmluL2Jhc2gNCg0KaT0xDQoNCnRlc3RkaXI9ImBwd2RgL2ZvbyINCg0KKHJtIC1yZiAiJHRl
c3RkaXIiOyBybSAtcmYgIiR0ZXN0ZGlyIikgJj4vZGV2L251bGwNCm1rZGlyIC1wICIkdGVzdGRp
ciINCg0KZm9yIHggaW4gJChjYXQgbGlzdCkNCmRvDQoJdGVtcD0iJHRlc3RkaXIvJHt4LzNwbS90
bXB9Ig0KCXg9IiR0ZXN0ZGlyLyR7eH0iDQoNCgl0b3VjaCAiJHRlbXAiDQoJbG4gIiR0ZW1wIiAi
JHgiDQoJcm0gLWYgIiR0ZW1wIg0KDQojCWVjaG8gIlBhc3MgJGkiDQoNCiMJaT0kKChpKzEpKQ0K
ZG9uZQ0KDQo=

--=-+T6801hlD5evnhgPljxk
Content-Disposition: attachment; filename=list
Content-Type: text/plain; name=list; charset=iso-8859-1
Content-Transfer-Encoding: base64

RmNudGwuM3BtDQpIYXNoOjpVdGlsLjNwbQ0KSTE4Tjo6Q29sbGF0ZS4zcG0NCkkxOE46OkxhbmdU
YWdzLjNwbQ0KSTE4Tjo6TGFuZ1RhZ3M6Okxpc3QuM3BtDQpJMThOOjpMYW5naW5mby4zcG0NCklP
LjNwbQ0KSU86OkRpci4zcG0NCklPOjpGaWxlLjNwbQ0KSU86OkhhbmRsZS4zcG0NCklPOjpQaXBl
LjNwbQ0KSU86OlBvbGwuM3BtDQpJTzo6U2Vla2FibGUuM3BtDQpJTzo6U2VsZWN0LjNwbQ0KSU86
OlNvY2tldC4zcG0NCklPOjpTb2NrZXQ6OklORVQuM3BtDQpJTzo6U29ja2V0OjpVTklYLjNwbQ0K
SVBDOjpNc2cuM3BtDQpJUEM6Ok9wZW4yLjNwbQ0KSVBDOjpPcGVuMy4zcG0NCklQQzo6U2VtYXBo
b3JlLjNwbQ0KSVBDOjpTeXNWLjNwbQ0KTGlzdDo6VXRpbC4zcG0NCkxvY2FsZTo6Q29uc3RhbnRz
LjNwbQ0KTG9jYWxlOjpDb3VudHJ5LjNwbQ0KTG9jYWxlOjpDdXJyZW5jeS4zcG0NCkxvY2FsZTo6
TGFuZ3VhZ2UuM3BtDQpMb2NhbGU6Ok1ha2V0ZXh0LjNwbQ0KTG9jYWxlOjpNYWtldGV4dDo6VFBK
MTMuM3BtDQpMb2NhbGU6OlNjcmlwdC4zcG0NCk1JTUU6OkJhc2U2NC4zcG0NCk1JTUU6OlF1b3Rl
ZFByaW50LjNwbQ0KTWF0aDo6QmlnRmxvYXQuM3BtDQpNYXRoOjpCaWdGbG9hdDo6VHJhY2UuM3Bt
DQpNYXRoOjpCaWdJbnQuM3BtDQpNYXRoOjpCaWdJbnQ6OkNhbGMuM3BtDQpNYXRoOjpCaWdJbnQ6
OlRyYWNlLjNwbQ0KTWF0aDo6QmlnUmF0LjNwbQ0KTWF0aDo6Q29tcGxleC4zcG0NCk1hdGg6OlRy
aWcuM3BtDQpNZW1vaXplLjNwbQ0KTWVtb2l6ZTo6QW55REJNX0ZpbGUuM3BtDQpNZW1vaXplOjpF
eHBpcmUuM3BtDQpNZW1vaXplOjpFeHBpcmVGaWxlLjNwbQ0KTWVtb2l6ZTo6RXhwaXJlVGVzdC4z
cG0NCk1lbW9pemU6Ok5EQk1fRmlsZS4zcG0NCk1lbW9pemU6OlNEQk1fRmlsZS4zcG0NCk1lbW9p
emU6OlN0b3JhYmxlLjNwbQ0KTkRCTV9GaWxlLjNwbQ0KTkVYVC4zcG0NCk5ldDo6Q21kLjNwbQ0K
TmV0OjpDb25maWcuM3BtDQpOZXQ6OkRvbWFpbi4zcG0NCk5ldDo6RlRQLjNwbQ0KTmV0OjpGVFA6
OkEuM3BtDQpOZXQ6OkZUUDo6RS4zcG0NCk5ldDo6RlRQOjpJLjNwbQ0KTmV0OjpGVFA6OkwuM3Bt
DQpOZXQ6OkZUUDo6ZGF0YWNvbm4uM3BtDQpOZXQ6Ok5OVFAuM3BtDQpOZXQ6Ok5ldHJjLjNwbQ0K
TmV0OjpQT1AzLjNwbQ0KTmV0OjpQaW5nLjNwbQ0KTmV0OjpTTVRQLjNwbQ0KTmV0OjpUaW1lLjNw
bQ0KTmV0Ojpob3N0ZW50LjNwbQ0KTmV0OjpsaWJuZXRGQVEuM3BtDQpOZXQ6Om5ldGVudC4zcG0N
Ck5ldDo6cHJvdG9lbnQuM3BtDQpOZXQ6OnNlcnZlbnQuM3BtDQpPLjNwbQ0KT3Bjb2RlLjNwbQ0K
UE9TSVguM3BtDQpQZXJsSU8uM3BtDQpQZXJsSU86OmVuY29kaW5nLjNwbQ0KUGVybElPOjpzY2Fs
YXIuM3BtDQpQZXJsSU86OnZpYS4zcG0NClBlcmxJTzo6dmlhOjpRdW90ZWRQcmludC4zcG0NClBv
ZDo6Q2hlY2tlci4zcG0NClBvZDo6RmluZC4zcG0NClBvZDo6SHRtbC4zcG0NClBvZDo6SW5wdXRP
YmplY3RzLjNwbQ0KUG9kOjpMYVRlWC4zcG0NClBvZDo6TWFuLjNwbQ0KUG9kOjpQYXJzZUxpbmsu
M3BtDQpQb2Q6OlBhcnNlVXRpbHMuM3BtDQpQb2Q6OlBhcnNlci4zcG0NClBvZDo6UGxhaW5lci4z
cG0NClBvZDo6U2VsZWN0LjNwbQ0KUG9kOjpUZXh0LjNwbQ0KUG9kOjpUZXh0OjpDb2xvci4zcG0N
ClBvZDo6VGV4dDo6T3ZlcnN0cmlrZS4zcG0NClBvZDo6VGV4dDo6VGVybWNhcC4zcG0NClBvZDo6
VXNhZ2UuM3BtDQpTREJNX0ZpbGUuM3BtDQpTYWZlLjNwbQ0KU2NhbGFyOjpVdGlsLjNwbQ0KU2Vh
cmNoOjpEaWN0LjNwbQ0KU2VsZWN0U2F2ZXIuM3BtDQpTZWxmTG9hZGVyLjNwbQ0KU2hlbGwuM3Bt
DQpTb2NrZXQuM3BtDQpTdG9yYWJsZS4zcG0NClN3aXRjaC4zcG0NClN5bWJvbC4zcG0NClN5czo6
SG9zdG5hbWUuM3BtDQpTeXM6OlN5c2xvZy4zcG0NClRlcm06OkFOU0lDb2xvci4zcG0NClRlcm06
OkNhcC4zcG0NClRlcm06OkNvbXBsZXRlLjNwbQ0KVGVybTo6UmVhZExpbmUuM3BtDQpUZXN0LjNw
bQ0KVGVzdDo6QnVpbGRlci4zcG0NClRlc3Q6Okhhcm5lc3MuM3BtDQpUZXN0OjpIYXJuZXNzOjpB
c3NlcnQuM3BtDQpUZXN0OjpIYXJuZXNzOjpJdGVyYXRvci4zcG0NClRlc3Q6Okhhcm5lc3M6OlN0
cmFwcy4zcG0NClRlc3Q6Ok1vcmUuM3BtDQpUZXN0OjpTaW1wbGUuM3BtDQpUZXN0OjpUdXRvcmlh
bC4zcG0NClRleHQ6OkFiYnJldi4zcG0NClRleHQ6OkJhbGFuY2VkLjNwbQ0KVGV4dDo6UGFyc2VX
b3Jkcy4zcG0NClRleHQ6OlNvdW5kZXguM3BtDQpUZXh0OjpUYWJzLjNwbQ0KVGV4dDo6V3JhcC4z
cG0NClRocmVhZC4zcG0NClRocmVhZDo6UXVldWUuM3BtDQpUaHJlYWQ6OlNlbWFwaG9yZS4zcG0N
ClRpZTo6QXJyYXkuM3BtDQpUaWU6OkZpbGUuM3BtDQpUaWU6OkhhbmRsZS4zcG0NClRpZTo6SGFz
aC4zcG0NClRpZTo6TWVtb2l6ZS4zcG0NClRpZTo6UmVmSGFzaC4zcG0NClRpZTo6U2NhbGFyLjNw
bQ0KVGllOjpTdWJzdHJIYXNoLjNwbQ0KVGltZTo6SGlSZXMuM3BtDQpUaW1lOjpMb2NhbC4zcG0N
ClRpbWU6OmdtdGltZS4zcG0NClRpbWU6OmxvY2FsdGltZS4zcG0NClRpbWU6OnRtLjNwbQ0KVU5J
VkVSU0FMLjNwbQ0KVW5pY29kZTo6Q29sbGF0ZS4zcG0NClVuaWNvZGU6Ok5vcm1hbGl6ZS4zcG0N
ClVuaWNvZGU6OlVDRC4zcG0NClVzZXI6OmdyZW50LjNwbQ0KVXNlcjo6cHdlbnQuM3BtDQpXaW4z
Mi4zcG0NClhTOjpBUEl0ZXN0LjNwbQ0KWFM6OlR5cGVtYXAuM3BtDQpYU0xvYWRlci4zcG0NCg==

--=-+T6801hlD5evnhgPljxk--

--=-sS7VnH+9h5AkNLDJGLBc
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/MYD3qburzKaJYLYRAsrlAKCayikbtY2jS+GkxBUioOeX7pZEWgCeP2Mx
W0qjZzcTU3qvVk4LWwWKXh8=
=D+Kn
-----END PGP SIGNATURE-----

--=-sS7VnH+9h5AkNLDJGLBc--

