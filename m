Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263039AbTJZJtf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Oct 2003 04:49:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263050AbTJZJtb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Oct 2003 04:49:31 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:15623 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S263039AbTJZJt1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Oct 2003 04:49:27 -0500
Date: Sun, 26 Oct 2003 10:49:23 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Stephen Smalley <sds@epoch.ncsc.mil>, jmorris@redhat.com,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Sam Ravnborg <sam@ravnborg.org>
Subject: Re: 2.6.0-test9: selinux compile error with "make O=..."
Message-ID: <20031026094923.GA925@mars.ravnborg.org>
Mail-Followup-To: Adrian Bunk <bunk@fs.tum.de>,
	Stephen Smalley <sds@epoch.ncsc.mil>, jmorris@redhat.com,
	Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Sam Ravnborg <sam@ravnborg.org>
References: <Pine.LNX.4.44.0310251152410.5764-100000@home.osdl.org> <20031026002209.GD23291@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031026002209.GD23291@fs.tum.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 26, 2003 at 02:22:09AM +0200, Adrian Bunk wrote:
> The problem comes from the following line in 
> security/selinux/ss/Makefile:
>   EXTRA_CFLAGS += -Isecurity/selinux/include -include security/selinux/ss/global.h

Hi Adrian.
Known problem that has been reported back to the maintainers about
one month ago. But they do not seem to care enough to fix it.

The use of "-include" is a bad way to include files. The reader will
not see that global.h is included at all and will wonder how that
information get pulled in.

Furhtermore the location of the header files under security/include
is considered bad practice. All headerfiles used from more than one
directory belongs to include/xxx, in this case include/security.
Then they can be included using
#include <security/secuity.h>

Everything are post 2.6.0 material.

	Sam
