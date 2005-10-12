Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964787AbVJLU0K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964787AbVJLU0K (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Oct 2005 16:26:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964799AbVJLU0K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Oct 2005 16:26:10 -0400
Received: from zproxy.gmail.com ([64.233.162.195]:5725 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964787AbVJLU0J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Oct 2005 16:26:09 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type;
        b=JRujL34DDHSGpb6mnk8rdj9BWm5+aci0uUYEQW3cRGq+rjvyfnIpNKjOnBbCUN6XmlqMj46kxl+NavbnuSNBfV3pO5vPJykm0sxbD8sg1VKhRtZR/nLvlJBKy/Btwcn3FobDZI5zYDj8Pl2hEOUIH3m+E76qwbIhRE+hDCs/QaQ=
Message-ID: <a5d587fb0510121326m7513bfbdn6e77a30da48a7156@mail.gmail.com>
Date: Wed, 12 Oct 2005 22:26:06 +0200
From: Michal Suchanek <hramrach@gmail.com>
To: John McCutchan <ttb@tentacle.dhs.org>, Robert Love <rml@novell.com>,
       linux-kernel@vger.kernel.org
Subject: Not receiving MOVE_TO events with inotify
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_42639_8945545.1129148766092"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_42639_8945545.1129148766092
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Content-Disposition: inline

SGVsbG8KCkkgdHJpZWQgdGhlIGlub3RpZnkgZmVhdHVyZSBhbmQgSSBmb3VuZCBJIGRvIG5vdCBy
ZWNlaXZlIE1PVkVfVE8gZXZlbnRzLgpJIHVzZSBsaW51eCAyLjYuMTMgZnJvbSBEZWJpYW4sIGV4
dDMgZmlsZXN5c3RlbS4KCkkgc2V0IGEgd2F0Y2ggb24gL3RtcC4gV2hlbiBJIG1vdmUgL3RtcC9m
aWxlX2EgdG8gL3RtcC9maWxlX2IgSQpyZWNlaXZlIG9ubHkgb25lIGV2ZW50IG9uIGZpbGVfYSAo
SSBhc3N1bWUgaXQgaXMgbW92ZV9mcm9tLCBJIGRpZCBub3QKZGVjb2RlIGl0KS4KCkF0dGFjaGlu
ZyBhIHNtYWxsIEMgcHJvZ3JhbSB0aGF0IEkgdXNlZCB0byBwcmludCBldmVudHMgdGhhdCBvY2N1
ciBvbiAvdG1wLgoKVGhhbmtzCgpNaWNoYWwgU3VjaGFuZWsKCgotLQpTdXBwb3J0IHRoZSBmcmVl
ZG9tIG9mIG11c2ljIQpNYXliZSBpdCdzIGEgd2VpcmQgZ2VucmUgIC4uIGJ1dCB3ZWlyZCBpcyAq
bm90KiBpbGxlZ2FsLgpNYXliZSBuZXh0IHRpbWUgdGhleSB3aWxsIHNlbmQgYSBzcGVjaWFsIGZv
cmNlcyBjb21tYW5kbyB0byB5b3VyIHBpY25pYyAuLgouLiBiZWNhdXNlIHRoZXkgdGhpbmsgeW91
IGFyZSB3ZWlyZC4KICAgaHR0cDovL3d3dy5tdXNpYy12ZXJzdXMtZ3Vucy5vcmcgICAgICAgICAg
aHR0cDovL2VuLnBvbGljZWpuaXN0YXQuY3oK
------=_Part_42639_8945545.1129148766092
Content-Type: text/x-csrc; name=test.c; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="test.c"

#include <linux/inotify.h>
#include <sys/syscall.h>
#include <errno.h>
#include <unistd.h>
#include <stdio.h>

static inline _syscall0(int, inotify_init);

static inline _syscall3(int, inotify_add_watch, int, fd, const char *, path, __u32, mask);

static inline _syscall2(int, inotify_rm_watch, int, fd, int, wd);

#define BUFSIZE 4096

typedef struct inotify_event ine;

int main (int argc, char ** argv)
{
  int fd = inotify_init();
  int wd = inotify_add_watch(fd, "/tmp", IN_ALL_EVENTS);
  static char buf[BUFSIZE];
  size_t len;

  while(1){
    ine * pev;
    len = read(fd, buf, BUFSIZE);
    if(!len) { putchar('.'); sleep(5); continue;}
    pev = (ine *) buf;
    while(buf + len > (char *)pev) {
      fprintf(stderr, "%s(%u): %x\n", pev->len ? pev->name : "(self)" , pev->wd, pev->mask);
      pev = (ine *)((char *)(pev + 1)) + pev->len;
    }
  }
}



------=_Part_42639_8945545.1129148766092--
