Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263275AbTFDMWP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 08:22:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263277AbTFDMWP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 08:22:15 -0400
Received: from uucp.cistron.nl ([62.216.30.38]:7685 "EHLO ncc1701.cistron.net")
	by vger.kernel.org with ESMTP id S263275AbTFDMWO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 08:22:14 -0400
From: miquels@cistron-office.nl (Miquel van Smoorenburg)
Subject: Re: -rc7   Re: Linux 2.4.21-rc6
Date: Wed, 4 Jun 2003 12:35:42 +0000 (UTC)
Organization: Cistron Group
Message-ID: <bbkp2u$v43$2@news.cistron.nl>
References: <Pine.LNX.4.55L.0305282019160.321@freak.distro.conectiva> <200306041246.21636.m.c.p@wolk-project.de> <20030604104825.GR3412@x30.school.suse.de> <3EDDDEBB.4080209@cyberone.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: ncc1701.cistron.net 1054730142 31875 62.216.29.200 (4 Jun 2003 12:35:42 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: miquels@cistron-office.nl (Miquel van Smoorenburg)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <3EDDDEBB.4080209@cyberone.com.au>,
Nick Piggin  <piggin@cyberone.com.au> wrote:
>-	char			plugged;
>+	int			plugged:1;

This is dangerous:

struct foo {
        int     bla:1;
};
 
int main()
{
        struct foo      f;
 
        f.bla = 1;
        printf("%d\n", f.bla);
}


$ ./a.out
-1

If you want to put "0" and "1" in a 1-bit field, use "unsigned int bla:1".

Mike.
-- 
.. somehow I have a feeling the hurting hasn't even begun yet
	-- Bill, "The Terrible Thunderlizards"

