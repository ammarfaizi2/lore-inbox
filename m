Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261422AbVEDT2x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261422AbVEDT2x (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 May 2005 15:28:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261423AbVEDT2x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 May 2005 15:28:53 -0400
Received: from fire.osdl.org ([65.172.181.4]:11485 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261422AbVEDT2p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 May 2005 15:28:45 -0400
Date: Wed, 4 May 2005 12:28:36 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Krzysztof Halasa <khc@pm.waw.pl>, kernel-mentors@selenic.com
Cc: haveblue@us.ibm.com, Valdis.Kletnieks@vt.edu, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] update SubmittingPatches to clarify attachment
 policy
Message-Id: <20050504122836.69205a04.rddunlap@osdl.org>
In-Reply-To: <m364xysu0y.fsf@defiant.localdomain>
References: <20050504170156.87F67CE5@kernel.beaverton.ibm.com>
	<200505041716.j44HGPbV016851@turing-police.cc.vt.edu>
	<1115227516.22718.4.camel@localhost>
	<m364xysu0y.fsf@defiant.localdomain>
Organization: OSDL
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart=_Wed__4_May_2005_12_28_36_-0700_kMsFJMDnPyY3zZ3C"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--Multipart=_Wed__4_May_2005_12_28_36_-0700_kMsFJMDnPyY3zZ3C
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 04 May 2005 20:52:45 +0200
Krzysztof Halasa <khc@pm.waw.pl> wrote:

> There is MIME "Content-Disposition: inline".
> Personally I think it's at least as good as plain text - it's MIME
> attachment (you can extract automatically, you have well-defined patch
> boundaries, original file name etc.) _and_ mail readers are supposed to
> (and do) display such attachments as normal message parts.
> 
> The message is readable with MIME-unaware readers (scripts etc.) as well.
> 
> Such attachment (raw message data) looks like:
> 
[snip]
> 
> > +code.  If you must use an attachment,
> 
> > verify that it has no
> > +Content-Type-Encoding.
> 
> Content-Transfer-Encoding.
> 
> I'd say "verify that it's binary-encoded - quoted-printable and base64
> encodings are not permitted".
> 
> I.e., it's perfectly fine to specify "Content-Transfer-Encoding: 7bit"
> (or "8bit" or possibly "binary", though I don't exactly know the
> difference between "8bit" and "binary").
> 
> >  A MIME attachment also takes Linus a bit more
> > +time to process, decreasing the likelihood of your MIME-attached
> > +change being accepted.
> 
> I don't think so. Badly formatted MIME attachments, sure. I'd be
> surprised if Linus applies them at all.
> 
> >  Exception:  If your mailer is mangling patches then someone may ask
> > -you to re-send them using MIME.
> > +you to re-send them compressed or using other MIME encodings.
> 
> Rather: "... someone may ask you to re-send them as properly encoded
> MIME attachments".
> 
> 
> In fact I'd encourage using binary-encoded inlined MIME attachments
> at all times, with non-MIME 7bit or 8bit plain text being accepted
> as secondary format.


A couple of days ago, Matt Mackall described/proposed a tool to
check new patches for acceptable content and format:
  http://www.selenic.com/pipermail/kernel-mentors/2005-May/000072.html

I'm attaching a rudimentary version of such a tool (check-patch.pl).
It does not attempt to check for line wrapping or lines that are
> 80 characters.
It dislikes patches that contain attachments that are base64,
quoted-printable, or binary (e.g.).

People can run this script locally, but ideally We (royal) will
have an email address for it so that people can use it to check
if their mail interface munges the patch for them... :(
and can try again until it doesn't.

Yeah, it's not perfect and it's a bit verbose.
Patches accepted (or even complete rewrites :).

---
~Randy

--Multipart=_Wed__4_May_2005_12_28_36_-0700_kMsFJMDnPyY3zZ3C
Content-Type: application/octet-stream;
 name="check-patch.pl"
Content-Disposition: attachment;
 filename="check-patch.pl"
Content-Transfer-Encoding: base64

IyEgL3Vzci9iaW4vcGVybAojIFJhbmR5IER1bmxhcCA8cmRkdW5sYXBAb3NkbC5vcmc+CiMgMjAw
NS0wNS0wMgojCiNNYXR0IE1hY2thbGwgd3JvdGU6CiNJIHRoaW5rIGEgbWFpbCByb2JvdCB0aGF0
IHlvdSBjb3VsZCBzZW5kIHBhdGNoZXMgdG8gdGhhdCB3b3VsZCBkZXRlY3Q6CiMtIHF1b3RlZCBw
cmludGFibGUKIy0gbGluZSB3cmFwcGluZwojLSB0YWIgZGFtYWdlCiMtIHdyb25nIGRpcmVjdG9y
eSBsZXZlbAojLSBub24tdW5pZGlmZgojLSBhZGRlZCB0cmFpbGluZyB3aGl0ZXNwYWNlCiMtIGV0
Yy4KIy0gbGluZXMgbG9uZ2VyIHRoYW4gODAgY2hhcmFjdGVycwojLSB1c2Ugb2YgLy8gc3R5bGUg
Y29tbWVudHMKIwojLi53b3VsZCBiZSBxdWl0ZSB1c2VmdWwuIFRoZW4gd2UgY291bGQganVzdCBz
YXkgInlvdXIgcGF0Y2ggaXMKI2RhbWFnZWQsIHJlc2VuZCB0byBwYXRjaC10ZXN0ZXJAZm9vLm9y
ZyB1bnRpbCBpdCBzYXlzIGl0IGxvb2tzIG9rIi4KIwojQW55IHZvbHVudGVlcnM/IAojLS0gCgok
dGFiY291bnQgPSAwOwokc3BhY2VzX3J1biA9IDA7CiR0cmFpbGluZ193cyA9IDA7CiRkb3VibGVf
c2xhc2hlcyA9IDA7CiRiYWRfZW5jb2RpbmdzID0gMDsKJG5vdF91bmlkaWZmID0gMDsKJG5vdF9w
ZGlmZiA9IDA7CiRiYWRfc3ViZGlyID0gMDsKCiVrZXJuZWxfZGlycyA9ICgiYXJjaCIsIDEsICJj
cnlwdG8iLCAxLCAiZHJpdmVycyIsIDEsICJmcyIsIDEsCgkJImluY2x1ZGUiLCAxLCAiaW5pdCIs
IDEsICJpcGMiLCAxLCAia2VybmVsIiwgMSwKCQkibGliIiwgMSwgIm1tIiwgMSwgIm5ldCIsIDEs
ICJzY3JpcHRzIiwgMSwKCQkic2VjdXJpdHkiLCAxLCAic291bmQiLCAxLCAidXNyIiwgMSwgIkRv
Y3VtZW50YXRpb24iLCAxKTsKCiMgZ2V0IGlucHV0IGZpbGUgbmFtZToKJElOUFVUTkFNRSA9ICRB
UkdWWzBdOwoKaWYgKGxlbmd0aCAoJElOUFVUTkFNRSkgPT0gMCkgewogICAgICAgIHByaW50ICJ1
c2FnZTogY2hlY2stcGF0Y2gucGwgcGF0Y2hmaWxlXG5cbiI7CiAgICAgICAgZXhpdCAxOwp9Cgpp
ZiAoISBvcGVuIChJTlBVVE5VTSwgIjwkSU5QVVROQU1FIikpIHsKICAgICAgICBwcmludCAiY2Fu
bm90IG9wZW4gJyRJTlBVVE5BTUUnXG5cbiI7CiAgICAgICAgZXhpdCAyOwp9CgpwcmludCAiJElO
UFVUTkFNRSA6XG4iOwoKcmVhZHBhdGNoOiB3aGlsZSAoJGxpbmUgPSA8SU5QVVROVU0+KQp7Cglj
aG9tcCAkbGluZTsKCSMgcHJpbnQgImRlYjogI2xpbmUgPSB7JGxpbmV9XG4iOwoKCSR0YWJjb3Vu
dCsrIGlmICRsaW5lID1+IC9cdC87Cgkkc3BhY2VzX3J1bisrIGlmICRsaW5lID1+IC8gICAgLzsK
CSR0cmFpbGluZ193cysrIGlmICRsaW5lID1+IC9eXCsuKlsgXHRdJC87CgkkZG91YmxlX3NsYXNo
ZXMrKyBpZiAkbGluZSA9fiAvXC9cLy87CgoJaWYgKCRsaW5lID1+IC9Db250ZW50LVRyYW5zZmVy
LUVuY29kaW5nOi9pKSB7CgkJaWYgKCgkbGluZSA9fiAvYmFzZTY0L2kpIHx8CgkJICAgICgkbGlu
ZSA9fiAvYmluYXJ5L2kpIHx8CgkJICAgICgkbGluZSA9fiAvcXVvdGVkLXByaW50YWJsZS9pKSkg
ewoJCQkkYmFkX2VuY29kaW5ncysrOwoJCQlwcmludCAiYmFkIGVuY29kaW5nOiAkbGluZVxuIjsK
CQl9Cgl9CgoJaWYgKCRsaW5lID1+IC9eZGlmZi8pIHsKCQlpZiAoJGxpbmUgIX4gLy0uKnUvKSB7
CgkJCXByaW50ICJhcHBlYXJzIG5vdCB0byBiZSBhIC11IGRpZmZcbiI7CgkJCSRub3RfdW5pZGlm
ZisrOwoJCX0KCQlpZiAoJGxpbmUgIX4gLy0uKnAvKSB7CgkJCXByaW50ICJhcHBlYXJzIG5vdCB0
byBiZSBhIC1wIGRpZmZcbiI7CgkJCSRub3RfcGRpZmYrKzsKCQl9Cgl9CgoJaWYgKCRsaW5lID1+
IC9eLS0tIC8gfHwgJGxpbmUgPX4gL15cK1wrXCsgLykgewoJCSRmaWxlbmFtZSA9IHN1YnN0cigk
bGluZSwgNCk7CgkJQGRpZmZsaW5lID0gc3BsaXQoJyAnLCAkZmlsZW5hbWUpOyAjIGZpbGVuYW1l
IGRhdGUgdGltZQoJCUBmbnBhcnRzID0gc3BsaXQoJy8nLCAkZGlmZmxpbmVbMF0pOwoJCSRzdWJk
aXIgPSAkZm5wYXJ0c1sxXTsKCQlpZiAoKHN1YnN0cigkc3ViZGlyLCBsZW5ndGgoJHN1YmRpcikg
LSAxLCAxKSBlcSAnLycpICYmCgkJICAgICAgICgka2VybmVsX2RpcnN7JHN1YmRpcn0gIT0gMSkp
IHsKCQkJJGVuZGluZyA9IHN1YnN0cigkc3ViZGlyLCBsZW5ndGgoJHN1YmRpcikgLSAxLCAxKTsK
CQkJcHJpbnQgImJhZCBzdWItZGlyIGxldmVsIHskZW5kaW5nfVskc3ViZGlyXTogJGxpbmVcbiI7
CgkJCSRiYWRfc3ViZGlyKys7CgkJfQoJfQp9ICMgZW5kIHJlYWRwYXRjaAoKY2xvc2UgKElOUFVU
TlVNKTsKCnByaW50ICIgIHRhYiBjb3VudDogJHRhYmNvdW50XG4iOwpwcmludCAiICBzcGFjZXNf
cnVuIGNvdW50OiAkc3BhY2VzX3J1blxuIjsKCnByaW50ICIgIHRyYWlsaW5nIHdoaXRlc3BhY2U6
ICR0cmFpbGluZ193c1xuIjsKcHJpbnQgIiAgYmFkIGVuY29kaW5nczogJGJhZF9lbmNvZGluZ3Nc
biI7CnByaW50ICIgICcvLycgY29tbWVudHM6ICRkb3VibGVfc2xhc2hlc1xuIjsKcHJpbnQgIiAg
bm90IC11IGRpZmY6ICRub3RfdW5pZGlmZlxuIjsKcHJpbnQgIiAgbm90IC1wIGRpZmY6ICRub3Rf
cGRpZmZcbiI7CnByaW50ICIgIGJhZCBzdWItZGlyIGxldmVsOiAkYmFkX3N1YmRpclxuIjsKCmlm
ICgkdGFiY291bnQgPT0gMCAmJiAkc3BhY2VzX3J1biA+IDApIHsKCXByaW50ICIgIFdBUk5JTkc6
IG5vIHRhYnMgZm91bmQsIGxvdHMgb2Ygc3BhY2VzIGZvdW5kOyBub3QgYSBnb29kIHNpZ25cbiI7
Cn0KCiRlcnJzID0gJHRyYWlsaW5nX3dzICsgJGJhZF9lbmNvZGluZ3MgKyAkZG91YmxlX3NsYXNo
ZXMgKyAkbm90X3VuaWRpZmYgKyAkbm90X3BkaWZmCgkrICRiYWRfc3ViZGlyOwoKaWYgKCRlcnJz
ID09IDApIHsKCXByaW50ICIgIFBBU1MgKG5vIGVycm9ycylcbiI7Cn0KZWxzZSB7CglwcmludCAi
ICAjIyMjIyAkZXJycyBlcnJvcihzKSAjIyMjI1xuIjsKfQoKIyBlbmQuCg==

--Multipart=_Wed__4_May_2005_12_28_36_-0700_kMsFJMDnPyY3zZ3C--
