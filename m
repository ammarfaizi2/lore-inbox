Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932613AbVIHPGd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932613AbVIHPGd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 11:06:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932620AbVIHPGd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 11:06:33 -0400
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:45665
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S932613AbVIHPGb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 11:06:31 -0400
Message-Id: <43206FD70200007800024459@emea1-mh.id2.novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0 
Date: Thu, 08 Sep 2005 17:07:35 +0200
From: "Jan Beulich" <JBeulich@novell.com>
To: <sam@ravnborg.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: [PATCH] adjust .version updating
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=__PartFFDD91A7.1__="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME message. If you are reading this text, you may want to 
consider changing to a mail reader or gateway that understands how to 
properly handle MIME multipart messages.

--=__PartFFDD91A7.1__=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

(Note: Patch also attached because the inline version is certain to get
line wrapped.)

In order to maintain a more correct build number, updates to the
version
number should only be commited after a successful link of vmlinux, not
before (so that errors in the link process don't lead to pointless
increments).

Signed-off-by: Jan Beulich <jbeulich@novell.com>

diff -Npru 2.6.13/Makefile 2.6.13-version-update/Makefile
--- 2.6.13/Makefile	2005-08-29 01:41:01.000000000 +0200
+++ 2.6.13-version-update/Makefile	2005-09-01 11:32:13.000000000
+0200
@@ -624,8 +624,13 @@ quiet_cmd_vmlinux__ ?= LD      $@
 # Generate new vmlinux version
 quiet_cmd_vmlinux_version = GEN     .version
       cmd_vmlinux_version = set -e;                     \
-	. $(srctree)/scripts/mkversion > .tmp_version;	\
-	mv -f .tmp_version .version;			\
+	if [ ! -r .version ]; then			\
+	  rm -f .version;				\
+	  echo 1 >.version;				\
+	else						\
+	  mv .version .old_version;			\
+	  expr 0$$(cat .old_version) + 1 >.version;	\
+	fi;						\
 	$(MAKE) $(build)=init
 
 # Generate System.map
@@ -727,6 +732,7 @@ endif # ifdef CONFIG_KALLSYMS
 # vmlinux image - including updated kernel symbols
 vmlinux: $(vmlinux-lds) $(vmlinux-init) $(vmlinux-main) $(kallsyms.o)
FORCE
 	$(call if_changed_rule,vmlinux__)
+	$(Q)rm -f .old_version
 
 # The actual objects are generated when descending, 
 # make sure no implicit rule kicks in


--=__PartFFDD91A7.1__=
Content-Type: application/octet-stream; name="linux-2.6.13-version-update.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="linux-2.6.13-version-update.patch"

KE5vdGU6IFBhdGNoIGFsc28gYXR0YWNoZWQgYmVjYXVzZSB0aGUgaW5saW5lIHZlcnNpb24gaXMg
Y2VydGFpbiB0byBnZXQKbGluZSB3cmFwcGVkLikKCkluIG9yZGVyIHRvIG1haW50YWluIGEgbW9y
ZSBjb3JyZWN0IGJ1aWxkIG51bWJlciwgdXBkYXRlcyB0byB0aGUgdmVyc2lvbgpudW1iZXIgc2hv
dWxkIG9ubHkgYmUgY29tbWl0ZWQgYWZ0ZXIgYSBzdWNjZXNzZnVsIGxpbmsgb2Ygdm1saW51eCwg
bm90CmJlZm9yZSAoc28gdGhhdCBlcnJvcnMgaW4gdGhlIGxpbmsgcHJvY2VzcyBkb24ndCBsZWFk
IHRvIHBvaW50bGVzcwppbmNyZW1lbnRzKS4KClNpZ25lZC1vZmYtYnk6IEphbiBCZXVsaWNoIDxq
YmV1bGljaEBub3ZlbGwuY29tPgoKZGlmZiAtTnBydSAyLjYuMTMvTWFrZWZpbGUgMi42LjEzLXZl
cnNpb24tdXBkYXRlL01ha2VmaWxlCi0tLSAyLjYuMTMvTWFrZWZpbGUJMjAwNS0wOC0yOSAwMTo0
MTowMS4wMDAwMDAwMDAgKzAyMDAKKysrIDIuNi4xMy12ZXJzaW9uLXVwZGF0ZS9NYWtlZmlsZQky
MDA1LTA5LTAxIDExOjMyOjEzLjAwMDAwMDAwMCArMDIwMApAQCAtNjI0LDggKzYyNCwxMyBAQCBx
dWlldF9jbWRfdm1saW51eF9fID89IExEICAgICAgJEAKICMgR2VuZXJhdGUgbmV3IHZtbGludXgg
dmVyc2lvbgogcXVpZXRfY21kX3ZtbGludXhfdmVyc2lvbiA9IEdFTiAgICAgLnZlcnNpb24KICAg
ICAgIGNtZF92bWxpbnV4X3ZlcnNpb24gPSBzZXQgLWU7ICAgICAgICAgICAgICAgICAgICAgXAot
CS4gJChzcmN0cmVlKS9zY3JpcHRzL21rdmVyc2lvbiA+IC50bXBfdmVyc2lvbjsJXAotCW12IC1m
IC50bXBfdmVyc2lvbiAudmVyc2lvbjsJCQlcCisJaWYgWyAhIC1yIC52ZXJzaW9uIF07IHRoZW4J
CQlcCisJICBybSAtZiAudmVyc2lvbjsJCQkJXAorCSAgZWNobyAxID4udmVyc2lvbjsJCQkJXAor
CWVsc2UJCQkJCQlcCisJICBtdiAudmVyc2lvbiAub2xkX3ZlcnNpb247CQkJXAorCSAgZXhwciAw
JCQoY2F0IC5vbGRfdmVyc2lvbikgKyAxID4udmVyc2lvbjsJXAorCWZpOwkJCQkJCVwKIAkkKE1B
S0UpICQoYnVpbGQpPWluaXQKIAogIyBHZW5lcmF0ZSBTeXN0ZW0ubWFwCkBAIC03MjcsNiArNzMy
LDcgQEAgZW5kaWYgIyBpZmRlZiBDT05GSUdfS0FMTFNZTVMKICMgdm1saW51eCBpbWFnZSAtIGlu
Y2x1ZGluZyB1cGRhdGVkIGtlcm5lbCBzeW1ib2xzCiB2bWxpbnV4OiAkKHZtbGludXgtbGRzKSAk
KHZtbGludXgtaW5pdCkgJCh2bWxpbnV4LW1haW4pICQoa2FsbHN5bXMubykgRk9SQ0UKIAkkKGNh
bGwgaWZfY2hhbmdlZF9ydWxlLHZtbGludXhfXykKKwkkKFEpcm0gLWYgLm9sZF92ZXJzaW9uCiAK
ICMgVGhlIGFjdHVhbCBvYmplY3RzIGFyZSBnZW5lcmF0ZWQgd2hlbiBkZXNjZW5kaW5nLCAKICMg
bWFrZSBzdXJlIG5vIGltcGxpY2l0IHJ1bGUga2lja3MgaW4K

--=__PartFFDD91A7.1__=--
