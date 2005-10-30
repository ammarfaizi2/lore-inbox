Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932354AbVJ3VrI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932354AbVJ3VrI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Oct 2005 16:47:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932355AbVJ3VrI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Oct 2005 16:47:08 -0500
Received: from [81.2.110.250] ([81.2.110.250]:53407 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S932354AbVJ3VrH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Oct 2005 16:47:07 -0500
Subject: Re: 2.6.14 assorted warnings
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Dave Jones <davej@redhat.com>
Cc: Keith Owens <kaos@ocs.com.au>, linux-kernel@vger.kernel.org
In-Reply-To: <20051028073049.GA27389@redhat.com>
References: <5455.1130484079@kao2.melbourne.sgi.com>
	 <20051028073049.GA27389@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sun, 30 Oct 2005 22:15:31 +0000
Message-Id: <1130710531.32734.5.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2005-10-28 at 03:30 -0400, Dave Jones wrote:
> gcc is dumb, it doesn't realise that the variable will be filled by another
> function if its passed thus..
> 
> 	unsigned long foo
> 	bar(&foo)
> 	if (foo==1)
> 		...
> 
> With bar() filling in content of foo.
> I believe there's at least once instance of this in gcc bugzilla.

gcc is a *LOT* smarter than you give it credit for. It will not warn for
cases where it isn't able to tell how foo is used passed with &foo. It
will warn for cases where it can

Compile the following program with and without -O2 and you'll see just
how smart gcc actually is

#include <stdio.h>

static void bar(char *x) {
  *x = 1;
}

static void baz(char *x) {
  printf("Wombat\n");
}

int main(int argc, char *argv[]) {
  char x,y;
  bar(&x);
  baz(&y);

  printf("%c,%c\n", x, y);
}

So I'd go look deeper for real bugs 

Alan


