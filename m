Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262630AbVCKJJ5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262630AbVCKJJ5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 04:09:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262632AbVCKJJ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 04:09:57 -0500
Received: from cpe-24-94-57-164.stny.res.rr.com ([24.94.57.164]:51621 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S262630AbVCKJHn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 04:07:43 -0500
Date: Fri, 11 Mar 2005 04:07:41 -0500 (EST)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@localhost.localdomain
Reply-To: rostedt@goodmis.org
To: LKML <linux-kernel@vger.kernel.org>
Subject: [Announce] Stream line modules from .config with streamline_config.pl
In-Reply-To: <200503110223.34461.dtor_core@ameritech.net>
Message-ID: <Pine.LNX.4.58.0503110338230.19798@localhost.localdomain>
References: <200503110223.34461.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-693439761-1110532061=:19798"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--8323328-693439761-1110532061=:19798
Content-Type: TEXT/PLAIN; charset=US-ASCII


Hi all,

I'm not sure if someone else did this, but I wrote this simple script that
turns off the modules from your config file that you are not currently
using.  After downloading a new kernel I usually use the .config from my
Debian distribution.  But this usually has way too many modules turned on
and my compile takes much longer than I prefer. So instead of searching
for all the modules that I need in "make *config" I wrote this script to
do it for me.

It's a small simple perl script (that's why it's attached and not on some
web site), and it can easily have options added to it, but it's good
enough for me, so that's where I left it.

Here's how it works and what it does.

1. Boot up the kernel that has the modules you want to load.
2. cd to the directory that holds the source of the kernel you
    just booted.
3. If it's not already there, copy the config file you want to start
    with to this directory, as .config.
4. Make sure all the modules you want/need are loaded.
5. run this script redirecting the output to another file.
6. copy this other file to .config (backing up your old one if you want).
7. Run "make oldconfig".

What this script does is simply, reads all the makefiles in the current
directory tree (find . -name Makefile). Searches each of these Makefiles
for the string "obj-$(CONFIG.*) += ..." (the real regular expression is
more complex, and the file is attached if you want to see it). It then
stores the object files associated to the CONFIG_.* and it handles
multiple lines that end with "\".

Then it runs "lsmod" to get what modules are loaded.

Finally it reads the .config file in the directory and prints it to
standard output.  When it finds a CONFIG_.*=m it checks to see if that
config had an object from lsmod associated to it, if so, then it prints it
as is, otherwise it turns it off.

Here's what I did with my Debian distribution:

  cd /usr/src/linux-2.6.10
  cp /boot/config-2.6.10-1-686-smp .config
  ~/bin/streamline_config > config_strip
  mv .config config_sav
  mv config_strip .config
  make oldconfig

Now this is the config file that I start with when downloading other
kernels.

Obviously if you don't load all the modules you want, or later buy a
new device that needs a module that wasn't loaded, you will need to figure
out what module to add and compile it.  Or use the saved config again
(you did save it?) and do this all over.

Well, do what you want with this, it's an unrescricted license. Comments?

If someone else had already done something like this, let me know. But I
wrote this and a colleage of mine suggested to send it here. So here it
is.

Cheers,

-- Steve


--8323328-693439761-1110532061=:19798
Content-Type: TEXT/x-perl; charset=US-ASCII; name="streamline_config.pl"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.58.0503110407410.19798@localhost.localdomain>
Content-Description: 
Content-Disposition: attachment; filename="streamline_config.pl"

IyEvdXNyL2Jpbi9wZXJsIC13DQojDQojIENvcHl3cml0ZSAyMDA1IC0gU3Rl
dmVuIFJvc3RlZHQNCiMNCiMgVGhpcyBjb2RlIGhhcyBubyByZXN0cmljdGlv
bnMgYW5kIE5PIFdBUlJBTlRZLiANCiMgIFVzZSBpdCBhdCB5b3VyIG93biBy
aXNrLCBkbyB3aGF0IHlvdSB3YW50IHdpdGggaXQsDQojICBKdXN0IGRvbid0
IGJsYW1lIG1lLg0KIw0KIyAgSXQncyBzaW1wbGUgZW5vdWdoIHRvIGZpZ3Vy
ZSBvdXQgaG93IHRoaXMgd29ya3MuDQojICBJZiBub3QsIHRoZW4geW91IGNh
biBhc2sgbWUgYXQgc3RyaXBjb25maWdAZ29vZG1pcy5vcmcNCiMgIA0KIyBX
aGF0IGl0IGRvZXM/DQojDQojICAgSWYgeW91IGhhdmUgaW5zdGFsbGVkIGEg
TGludXgga2VybmVsIGZyb20gYSBkaXN0cmlidXRpb24NCiMgICB0aGF0IHR1
cm5zIG9uIHdheSB0b28gbWFueSBtb2R1bGVzIHRoYW4geW91IG5lZWQsIGFu
ZCANCiMgICB5b3Ugb25seSB3YW50IHRoZSBtb2R1bGVzIHlvdSB1c2UsIHRo
YW4gdGhpcyBwcm9ncmFtDQojICAgaXMgcGVyZmVjdCBmb3IgeW91Lg0KIw0K
IyAgIEl0IGdpdmVzIHlvdSB0aGUgYWJpbGl0eSB0byB0dXJuIG9mZiBhbGwg
dGhlIG1vZHVsZXMgdGhhdCBhcmUNCiMgICBub3QgbG9hZGVkIG9uIHlvdXIg
c3lzdGVtLiANCiMNCiMgSG93dG86DQojDQojICAxLiBCb290IHVwIHRoZSBr
ZXJuZWwgdGhhdCB5b3Ugd2FudCB0byBzdHJlYW0gbGluZSB0aGUgY29uZmln
IG9uLg0KIyAgMi4gQ2hhbmdlIGRpcmVjdG9yeSB0byB0aGUgZGlyZWN0b3J5
IGhvbGRpbmcgdGhlIHNvdXJjZSBvZiB0aGUgDQojICAgICAgIGtlcm5lbCB0
aGF0IHlvdSBqdXN0IGJvb3RlZC4NCiMgIDMuIENvcHkgdGhlIGNvbmZpZ3Vy
YXRvbiBmaWxlIHRvIHRoaXMgZGlyZWN0b3J5IGFzIC5jb25maWcNCiMgIDQu
IEhhdmUgYWxsIHlvdXIgZGV2aWNlcyB0aGF0IHlvdSBuZWVkIG1vZHVsZXMg
Zm9yIGNvbm5lY3RlZCBhbmQNCiMgICAgICBvcGVyYXRpb25hbCAobWFrZSBz
dXJlIHRoYXQgdGhlaXIgY29ycmVzcG9uZGluZyBtb2R1bGVzIGFyZSBsb2Fk
ZWQpDQojICA1LiBSdW4gdGhpcyBzY3JpcHQgcmVkaXJlY3RpbmcgdGhlIG91
dHB1dCB0byBzb21lIG90aGVyIGZpbGUNCiMgICAgICAgbGlrZSBjb25maWdf
c3RyaXAuDQojICA2LiBCYWNrIHVwIHlvdXIgb2xkIGNvbmZpZyAoaWYgeW91
IHdhbnQgdG9vKS4NCiMgIDcuIGNvcHkgdGhlIGNvbmZpZ19zdHJpcCBmaWxl
IHRvIC5jb25maWcNCiMgIDguIFJ1biAibWFrZSBvbGRjb25maWciDQojICAN
CiMgIE5vdyB5b3VyIGtlcm5lbCBpcyByZWFkeSB0byBiZSBidWlsdCB3aXRo
IG9ubHkgdGhlIG1vZHVsZXMgdGhhdA0KIyAgYXJlIGxvYWRlZC4NCiMNCiMg
SGVyZSdzIHdoYXQgSSBkaWQgd2l0aCBteSBEZWJpYW4gZGlzdHJpYnV0aW9u
Lg0KIw0KIyAgICBjZCAvdXNyL3NyYy9saW51eC0yLjYuMTANCiMgICAgY3Ag
L2Jvb3QvY29uZmlnLTIuNi4xMC0xLTY4Ni1zbXAgLmNvbmZpZw0KIyAgICB+
L2Jpbi9zdHJlYW1saW5lX2NvbmZpZyA+IGNvbmZpZ19zdHJpcA0KIyAgICBt
diAuY29uZmlnIGNvbmZpZ19zYXYNCiMgICAgbXYgY29uZmlnX3N0cmlwIC5j
b25maWcNCiMgICAgbWFrZSBvbGRjb25maWcNCiMgDQpteSAkY29uZmlnID0g
Ii5jb25maWciOw0KbXkgJGxpbnV4cGF0aCA9ICIuIjsNCg0Kb3BlbihDSU4s
JGNvbmZpZykgfHwgZGllICJDYW4ndCBvcGVuIGN1cnJlbnQgY29uZmlnIGZp
bGU6ICRjb25maWciOw0KbXkgQG1ha2VmaWxlcyA9IGBmaW5kICRsaW51eHBh
dGggLW5hbWUgTWFrZWZpbGVgOw0KDQpteSAlb2JqZWN0czsNCm15ICR2YXI7
DQpteSAkY29udCA9IDA7DQoNCmZvcmVhY2ggbXkgJG1ha2VmaWxlIChAbWFr
ZWZpbGVzKSB7DQoJY2hvbXAgJG1ha2VmaWxlOw0KCQ0KCW9wZW4oTUlOLCRt
YWtlZmlsZSkgfHwgZGllICJDYW4ndCBvcGVuICRtYWtlZmlsZSI7DQoJd2hp
bGUgKDxNSU4+KSB7DQoJCW15ICRjYXRjaCA9IDA7DQoJCQ0KCQlpZiAoJGNv
bnQgJiYgLyhcUy4qKSQvKSB7DQoJCQkkb2JqcyA9ICQxOw0KCQkJJGNhdGNo
ID0gMTsNCgkJfQ0KCQkkY29udCA9IDA7DQoJCQ0KCQlpZiAoL29iai1cJFwo
KENPTkZJR19bXildKilcKVxzKlsrOl0/PVxzKiguKikvKSB7DQoJCQkkdmFy
ID0gJDE7DQoJCQkkb2JqcyA9ICQyOw0KCQkJJGNhdGNoID0gMTsNCgkJfQ0K
CQlpZiAoJGNhdGNoKSB7DQoJCQlpZiAoJG9ianMgPX4gbSwoLiopLyQsKSB7
DQoJCQkJJG9ianMgPSAkMTsNCgkJCQkkY29udCA9IDE7DQoJCQl9DQoJCQkN
CgkJCWZvcmVhY2ggbXkgJG9iaiAoc3BsaXQgL1xzKy8sJG9ianMpIHsNCgkJ
CQkkb2JqID1+IHMvLS9fL2c7DQoJCQkJaWYgKCRvYmogPX4gLyguKilcLm8k
Lykgew0KCQkJCQkkb2JqZWN0c3skMX0gPSAkdmFyOw0KCQkJCX0NCgkJCX0N
CgkJfQ0KCX0NCgljbG9zZShNSU4pOw0KfQ0KDQpteSAlbW9kdWxlczsNCg0K
b3BlbihMSU4sIi9zYmluL2xzbW9kfCIpIHx8IGRpZSAiQ2FudCBsc21vZCI7
DQp3aGlsZSAoPExJTj4pIHsNCgluZXh0IGlmICgvXk1vZHVsZS8pOyAgIyBT
a2lwIHRoZSBmaXJzdCBsaW5lLg0KCWlmICgvXihcUyspLykgew0KCQkkbW9k
dWxlc3skMX0gPSAxOw0KCX0NCn0NCmNsb3NlIChMSU4pOw0KDQpteSAlY29u
ZmlnczsNCmZvcmVhY2ggbXkgJG1vZHVsZSAoa2V5cyglbW9kdWxlcykpIHsN
CglpZiAoZGVmaW5lZCgkb2JqZWN0c3skbW9kdWxlfSkpIHsNCgkJJGNvbmZp
Z3N7JG9iamVjdHN7JG1vZHVsZX19ID0gJG1vZHVsZTsNCgl9IGVsc2Ugew0K
CQlwcmludCBTVERFUlIgIiRtb2R1bGUgY29uZmlnIG5vdCBmb3VuZCEhXG4i
Ow0KCX0NCn0NCg0Kd2hpbGUoPENJTj4pIHsNCglpZiAoL14oQ09ORklHLiop
PW0vKSB7DQoJCWlmIChkZWZpbmVkKCRjb25maWdzeyQxfSkpIHsNCgkJCXBy
aW50Ow0KCQl9IGVsc2Ugew0KCQkJcHJpbnQgIiMgJDEgaXMgbm90IHNldFxu
IjsNCgkJfQ0KCX0gZWxzZSB7DQoJCXByaW50Ow0KCX0NCn0NCmNsb3NlKENJ
Tik7DQo=

--8323328-693439761-1110532061=:19798--
