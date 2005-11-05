Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932090AbVKEQJP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932090AbVKEQJP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Nov 2005 11:09:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932093AbVKEQJP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Nov 2005 11:09:15 -0500
Received: from mx2.netapp.com ([216.240.18.37]:9794 "EHLO mx2.netapp.com")
	by vger.kernel.org with ESMTP id S932090AbVKEQJO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Nov 2005 11:09:14 -0500
X-IronPort-AV: i="3.97,293,1125903600"; 
   d="dif'?scan'208"; a="335415507:sNHT22393468"
Subject: Re: recent NFS problems?
From: Trond Myklebust <Trond.Myklebust@netapp.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, nfs@lists.sourceforge.net
In-Reply-To: <436C50FE.3030600@pobox.com>
References: <436C50FE.3030600@pobox.com>
Content-Type: multipart/mixed; boundary="=-2JRTVzvmu8cp4UQKCtE3"
Organization: Network Appliance, Inc
Date: Sat, 05 Nov 2005 10:50:02 -0500
Message-Id: <1131205802.8754.9.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
X-OriginalArrivalTime: 05 Nov 2005 15:50:03.0422 (UTC) FILETIME=[960D6BE0:01C5E220]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-2JRTVzvmu8cp4UQKCtE3
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sat, 2005-11-05 at 01:28 -0500, Jeff Garzik wrote:
> This is a bit weird.  Running 2.6.14-g6037d6bb (libata-dev.git branch 
> 'upstream') on both client and server.  Its latest Linux 
> (7015faa7df829876a0f931cd18aa6d7c24a1b581) plus one libata patch.  All 
> NFSv4 kernel options are enabled, on both client and server.
> 
> On Host A, I mirror a local directory /garz/nsmail to an NFS directory 
> Host_B:/g/g/nsmail via rsync+ssh.  Host A also NFS mounts Host_B:/g 
> locally.  mount on Host A says
> 
> 	host_b:/g on /g type nfs (rw,tcp,intr,posix,addr=10.10.10.1)
> 
> Seeing some directory weirdness, where wildcard matches fail 
> (NFS-related dcache bugs?) but direct accesses succeed:
> 
> [jgarzik@host_a~]$ ssh host_b "ls -d /g/g/nsmail/Trash.sbd/*11*"
> /g/g/nsmail/Trash.sbd/Sent.20051105
> /g/g/nsmail/Trash.sbd/Sent.20051105.msf
> /g/g/nsmail/Trash.sbd/Sent.20051105.sbd
> /g/g/nsmail/Trash.sbd/Trash.20051105
> /g/g/nsmail/Trash.sbd/Trash.20051105.msf
> /g/g/nsmail/Trash.sbd/Trash.20051105.sbd
> 
> [jgarzik@host_a ~]$ ls -d /g/g/nsmail/Trash.sbd/*11*
> ls: /g/g/nsmail/Trash.sbd/*11*: No such file or directory
> 
> [jgarzik@host_a ~]$ ls -l /g/g/nsmail/Trash.sbd/Trash.20051105
> -rw-rw-r--  1 jgarzik jgarzik 67484129 Nov  5 00:02 
> /g/g/nsmail/Trash.sbd/Trash.20051105
> 
> [jgarzik@host_a~]$ wc -l /g/g/nsmail/Trash.sbd/Trash.20051105
> 1739088 /g/g/nsmail/Trash.sbd/Trash.20051105

Hmm... Does reverting the attached patch help?

Cheers,
  Trond


--=-2JRTVzvmu8cp4UQKCtE3
Content-Disposition: inline; filename=linux-2.6.14-77-remove_lookup_parent_reval.dif
Content-Transfer-Encoding: base64
Content-Type: text/plain; name=linux-2.6.14-77-remove_lookup_parent_reval.dif; charset=utf-8

QXV0aG9yOiBDaHVjayBMZXZlciA8Y2VsQG5ldGFwcC5jb20+DQpEYXRlOiBUdWUsIDI1IE9jdCAy
MDA1IDExOjQ4OjM2IC0wNDAwDQpORlM6IG5mc19sb29rdXAgZG9lc24ndCBuZWVkIHRvIHJldmFs
aWRhdGUgdGhlIHBhcmVudCBkaXJlY3RvcnkncyBpbm9kZQ0KDQogbmZzX2xvb2t1cCgpIHVzZWQg
dG8gY29uc3VsdCBhIGxvb2t1cCBjYWNoZSBiZWZvcmUgdHJ5aW5nIGFuIGFjdHVhbCB3aXJlDQog
bG9va3VwIG9wZXJhdGlvbi4gIFRoZSBsb29rdXAgY2FjaGUgd291bGQgYmUgaW52YWxpZCwgb2Yg
Y291cnNlLCBpZiB0aGUNCiBwYXJlbnQgZGlyZWN0b3J5J3MgbXRpbWUgaGFkIGNoYW5nZWQsIHNv
IG5mc19sb29rdXAgcGVyZm9ybWVkIGFuIGlub2RlDQogcmV2YWxpZGF0aW9uIG9uIHRoZSBwYXJl
bnQuDQoNCiBTaW5jZSBuZnNfbG9va3VwKCkgZG9lc24ndCB1c2UgYSBjYWNoZSBhbnltb3JlLCB0
aGUgcmV2YWxpZGF0aW9uIGlzIG5vDQogbG9uZ2VyIG5lY2Vzc2FyeS4gIFRoZXJlIGFyZSBjYXNl
cyB3aGVyZSBpdCB3aWxsIGdlbmVyYXRlIGEgbG90IG9mDQogdW5uZWNlc3NhcnkgR0VUQVRUUiB0
cmFmZmljLg0KDQogU2VlIGh0dHA6Ly9idWd6aWxsYS5saW51eC1uZnMub3JnL3Nob3dfYnVnLmNn
aT9pZD05DQoNCiBUZXN0LXBsYW46DQogVXNlIGxuZGlyIGFuZCAicm0gLXJmIiBhbmQgd2F0Y2gg
Zm9yIGV4Y2VzcyBHRVRBVFRSIHRyYWZmaWMgb3IgYXBwbGljYXRpb24NCiBsZXZlbCBlcnJvcnMu
DQoNCiBTaWduZWQtb2ZmLWJ5OiBDaHVjayBMZXZlciA8Y2VsQG5ldGFwcC5jb20+DQogU2lnbmVk
LW9mZi1ieTogVHJvbmQgTXlrbGVidXN0IDxUcm9uZC5NeWtsZWJ1c3RAbmV0YXBwLmNvbT4NCi0t
LQ0KIGZzL25mcy9kaXIuYyB8ICAgIDYgLS0tLS0tDQogMSBmaWxlcyBjaGFuZ2VkLCA2IGRlbGV0
aW9ucygtKQ0KDQpJbmRleDogbGludXgtMi42L2ZzL25mcy9kaXIuYw0KPT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQ0KLS0t
IGxpbnV4LTIuNi5vcmlnL2ZzL25mcy9kaXIuYw0KKysrIGxpbnV4LTIuNi9mcy9uZnMvZGlyLmMN
CkBAIC04NTMsMTIgKzg1Myw2IEBAIHN0YXRpYyBzdHJ1Y3QgZGVudHJ5ICpuZnNfbG9va3VwKHN0
cnVjdCANCiAJZGVudHJ5LT5kX29wID0gTkZTX1BST1RPKGRpciktPmRlbnRyeV9vcHM7DQogDQog
CWxvY2tfa2VybmVsKCk7DQotCS8qIFJldmFsaWRhdGUgcGFyZW50IGRpcmVjdG9yeSBhdHRyaWJ1
dGUgY2FjaGUgKi8NCi0JZXJyb3IgPSBuZnNfcmV2YWxpZGF0ZV9pbm9kZShORlNfU0VSVkVSKGRp
ciksIGRpcik7DQotCWlmIChlcnJvciA8IDApIHsNCi0JCXJlcyA9IEVSUl9QVFIoZXJyb3IpOw0K
LQkJZ290byBvdXRfdW5sb2NrOw0KLQl9DQogDQogCS8qIElmIHdlJ3JlIGRvaW5nIGFuIGV4Y2x1
c2l2ZSBjcmVhdGUsIG9wdGltaXplIGF3YXkgdGhlIGxvb2t1cCAqLw0KIAlpZiAobmZzX2lzX2V4
Y2x1c2l2ZV9jcmVhdGUoZGlyLCBuZCkpDQo=


--=-2JRTVzvmu8cp4UQKCtE3--
