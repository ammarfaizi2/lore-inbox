Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262133AbTIWWFh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Sep 2003 18:05:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262141AbTIWWFg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Sep 2003 18:05:36 -0400
Received: from rav-az.mvista.com ([65.200.49.157]:60441 "EHLO
	zipcode.az.mvista.com") by vger.kernel.org with ESMTP
	id S262133AbTIWWFf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Sep 2003 18:05:35 -0400
Date: Tue, 23 Sep 2003 15:16:11 -0700
From: Deepak Saxena <dsaxena@mvista.com>
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: Linus Torvalds <torvalds@osdl.org>, Deepak Saxena <dsaxena@mvista.com>,
       linux-kernel@vger.kernel.org, marcelo.tosatti@cyclades.com.br
Subject: Re: [PATCH] Fix %x parsing in vsscanf()
Message-ID: <20030923221611.GA25464@xanadu.az.mvista.com>
Reply-To: dsaxena@mvista.com
References: <20030923212207.GA25234@xanadu.az.mvista.com> <Pine.LNX.4.44.0309231421450.24527-100000@home.osdl.org> <20030923213533.GN7665@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030923213533.GN7665@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.4i
Organization: MontaVista Software, Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sep 23 2003, at 22:35, viro@parcelfarce.linux.theplanet.co.uk was caught saying:
> On Tue, Sep 23, 2003 at 02:28:12PM -0700, Linus Torvalds wrote:
> > Fixing strtoul[l] should fix vsscanf() automatically, no? So I don't see 
> > the "have the check only once" argument.
> 
> C99 on behaviour of %x:
> 
> "Matches an optionally signed hexadecimal integer, whose format is the same as
> expected for the subject sequence of the strtoul function with the value 16
> for the base argument."
> 
> IOW, strtoul() is definitely the right place to fix that.

OK, given that and your previous message, here's an updated patch:

===== lib/vsprintf.c 1.1 vs edited =====
--- 1.1/lib/vsprintf.c	Tue Jan 22 19:31:16 2002
+++ edited/lib/vsprintf.c	Tue Sep 23 15:07:20 2003
@@ -32,6 +32,8 @@
 {
 	unsigned long result = 0,value;
 
+	if ((base == 16) && (cp[0] == '0' && (cp[1] == 'x' || cp[1] == 'X')))
+		cp += 2;
 	if (!base) {
 		base = 10;
 		if (*cp == '0') {
@@ -76,6 +78,8 @@
 {
 	unsigned long long result = 0,value;
 
+	if ((base == 16) && (cp[0] == '0' && (cp[1] == 'x' || cp[1] == 'X')))
+		cp += 2;
 	if (!base) {
 		base = 10;
 		if (*cp == '0') {

-- 
Deepak Saxena
MontaVista Software - Powering the Embedded Revolution - www.mvista.com
