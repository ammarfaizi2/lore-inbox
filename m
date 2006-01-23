Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964789AbWAWAn4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964789AbWAWAn4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jan 2006 19:43:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964792AbWAWAn4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jan 2006 19:43:56 -0500
Received: from zproxy.gmail.com ([64.233.162.205]:22508 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964789AbWAWAnz convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jan 2006 19:43:55 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=Z/Gmly5oqG6tnDSNrR76Y1B8FTIGOfvopJKK+qxeFLxXUZfTqamBAU/qctWw6ZO4QeeawIRmWet4rJt0+CWq3aVCE4WoFJltWn4do+e/DNW+mX1TYsksOdg18m7Kv2QuPlt9DDiLchShEOwWkOxTI3f89CLDgf3pTXdcGjT3ej4=
Message-ID: <787b0d920601221636h7acbb891wd52b88e0aea75aaf@mail.gmail.com>
Date: Sun, 22 Jan 2006 19:36:40 -0500
From: Albert Cahalan <acahalan@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: anon unions are cool
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the kernel requires a compiler that
supports anonymous unions, we can do some
really neat stuff.

For example, suppose we wanted to rename
a badly-named struct member. If the struct is
used all over the kernel, this becomes a giant
project with huge potential for patch conflicts.

Anonymous unions solve this. First, we replace
the badly-named struct member with an anonymous
union containing both the old name and the new
name. Second, we change much of the kernel
to use the new name. Third, we mark the old name
with the __depricated tag to generate warnings.
Fourth, we get the stragglers over days or months.
Fifth, we get rid of the anonymous union by replacing
it with the new name.

The struct evolves like so:

struct a {
  int foo;
  int bad;
  int bar;
};

struct a {
  int foo;
  union {
    int bad;
    int baz;
  };
  int bar;
};

struct a {
  int foo;
  union {
    int __deprecated bad;
    int baz;
  };
  int bar;
};

struct a {
  int foo;
  int baz;
  int bar;
};
