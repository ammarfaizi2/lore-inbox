Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264729AbRFQM2R>; Sun, 17 Jun 2001 08:28:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264728AbRFQM2H>; Sun, 17 Jun 2001 08:28:07 -0400
Received: from tele-post-20.mail.demon.net ([194.217.242.20]:58884 "EHLO
	tele-post-20.mail.demon.net") by vger.kernel.org with ESMTP
	id <S264726AbRFQM1x>; Sun, 17 Jun 2001 08:27:53 -0400
From: rjd@xyzzy.clara.co.uk
Message-Id: <200106171227.f5HCRZu10829@xyzzy.clara.co.uk>
Subject: Re: Newbie idiotic questions.
To: phillips@bonn-fries.net (Daniel Phillips)
Date: Sun, 17 Jun 2001 13:27:35 +0100 (BST)
Cc: jgarzik@mandrakesoft.com (Jeff Garzik),
        bpringle@sympatico.ca (Bill Pringlemeir), linux-kernel@vger.kernel.org
In-Reply-To: <0106171248010N.00879@starship> from "Daniel Phillips" at Jun 17, 2001 12:27:11 
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips wrote:
> 
> > because then you would be allocating the size of a pointer, not the size
> > of a structure
> 
> Whoops Jeff, you didn't have your coffee yet:

Whoops yourself. The following patch brings your example into line with
the driver code. mpuout is a pointer to a structure not the structure itself
as the malloc assignment clearly indicates.

*** x.c-orig	Sun Jun 17 13:19:33 2001
--- x.c	Sun Jun 17 13:19:42 2001
***************
*** 2,8 ****
  
  
  struct foo { int a; int b; };
! struct { struct foo foo; } *foobar;
  
  int main (void)
  {
--- 2,8 ----
  
  
  struct foo { int a; int b; };
! struct { struct foo *foo; } *foobar;
  
  int main (void)
  {


Now Prints:

	8
	4
	4


-- 
        Bob Dunlop                      FarSite Communications
        rjd@xyzzy.clara.co.uk           bob.dunlop@farsite.co.uk
        www.xyzzy.clara.co.uk           www.farsite.co.uk
