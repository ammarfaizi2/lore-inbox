Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267477AbUHPH4j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267477AbUHPH4j (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 03:56:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267484AbUHPH4j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 03:56:39 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:46826 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S267477AbUHPH4Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 03:56:25 -0400
Date: Mon, 16 Aug 2004 00:55:45 -0700 (PDT)
From: Ram Pai <linuxram@us.ibm.com>
X-X-Sender: ram@localhost.localdomain
Reply-To: linuxram@us.ibm.com
To: Andrew Morton <akpm@osdl.org>
cc: Phillip Lougher <phillip@lougher.demon.co.uk>, <nickpiggin@yahoo.com.au>,
       <linux-kernel@vger.kernel.org>,
       <viro@parcelfarce.linux.theplanet.co.uk>
Subject: [PATCH] Re: [PATCH] VFS readahead bug in 2.6.8-rc[1-3]
In-Reply-To: <20040806124609.3d489a0d.akpm@osdl.org>
Message-ID: <Pine.LNX.4.44.0408160052110.20970-200000@localhost.localdomain>
Organization: IBM Linux Technology Center
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-567590288-1092642945=:20970"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--8323328-567590288-1092642945=:20970
Content-Type: TEXT/PLAIN; charset=US-ASCII

On Fri, 6 Aug 2004, Andrew Morton wrote:

> Phillip Lougher <phillip@lougher.demon.co.uk> wrote:
> >
> > Nick Piggin wrote:
> > 
> > > No, I suggest you start to code assuming this interface does
> > > what it does. I didn't say there is no bug here, but nobody
> > > else's filesystem breaks.
> > > 
> > 
> > To stop this silly argument from escalating, I will patch my code.
> > 
> 
> Well I don't think it's silly.
> 
> We are deterministically asking the fs to read a page which lies outside
> EOF, and we shouldn't.  If for no other reason than that the ever-popular
> "read a million 4k files" workload will consume extra CPU and twice the
> pagecache.

Andrew,

	Enclosed a patch developed with Nick Piggin. It takes care of the
	bug. 

Thanks,
RP

--8323328-567590288-1092642945=:20970
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="filemap_index_overflow.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.44.0408160055450.20970@localhost.localdomain>
Content-Description: 
Content-Disposition: attachment; filename="filemap_index_overflow.patch"

LS0tIHJhbS9saW51eC0yLjYuOC4xL21tL2ZpbGVtYXAuYwkyMDA0LTA4LTE0
IDAzOjU2OjI1LjAwMDAwMDAwMCAtMDcwMA0KKysrIGxpbnV4LTIuNi44LjEv
bW0vZmlsZW1hcC5jCTIwMDQtMDgtMTYgMDc6NTY6MzEuOTEyMDM4NzIwIC0w
NzAwDQpAQCAtNjY1LDE0ICs2NjUsMTggQEAgdm9pZCBkb19nZW5lcmljX21h
cHBpbmdfcmVhZChzdHJ1Y3QgYWRkcg0KIAlvZmZzZXQgPSAqcHBvcyAmIH5Q
QUdFX0NBQ0hFX01BU0s7DQogDQogCWlzaXplID0gaV9zaXplX3JlYWQoaW5v
ZGUpOw0KLQllbmRfaW5kZXggPSBpc2l6ZSA+PiBQQUdFX0NBQ0hFX1NISUZU
Ow0KLQlpZiAoaW5kZXggPiBlbmRfaW5kZXgpDQorCWlmICghaXNpemUpDQog
CQlnb3RvIG91dDsNCisJCQ0KKwllbmRfaW5kZXggPSBpc2l6ZSA+PiBQQUdF
X0NBQ0hFX1NISUZUOw0KIA0KIAlmb3IgKDs7KSB7DQogCQlzdHJ1Y3QgcGFn
ZSAqcGFnZTsNCiAJCXVuc2lnbmVkIGxvbmcgbnIsIHJldDsNCiANCisJCWlm
IChpbmRleCA+IGVuZF9pbmRleCkNCisJCQlnb3RvIG91dDsNCisNCiAJCWNv
bmRfcmVzY2hlZCgpOw0KIAkJcGFnZV9jYWNoZV9yZWFkYWhlYWQobWFwcGlu
ZywgJnJhLCBmaWxwLCBpbmRleCk7DQogDQo=
--8323328-567590288-1092642945=:20970--
