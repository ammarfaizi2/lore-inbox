Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261852AbTEEAag (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 May 2003 20:30:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261861AbTEEAag
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 May 2003 20:30:36 -0400
Received: from 015.atlasinternet.net ([212.9.93.15]:30938 "EHLO
	antoli.gallimedina.net") by vger.kernel.org with ESMTP
	id S261852AbTEEAaf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 May 2003 20:30:35 -0400
From: Ricardo Galli <gallir@uib.es>
Organization: UIB
To: linux-kernel@vger.kernel.org
Subject: BUG: cpufreq_proc_read give prematures eof for /proc/cpufreq (in 2.4.x-ac and 2.5)
Date: Mon, 5 May 2003 02:43:01 +0200
User-Agent: KMail/1.5.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200305050243.01922.gallir@uib.es>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If a process reads from /proc/cpufreq with a small buffer, i.e. count < 
len, the function return always eof because len is always zero if the 
offset is > 0:

static int cpufreq_proc_read (
    char            *page,
...
{
    char            *p = page;
...

    if (off != 0)
        goto end;
    ...

end:
    len = (p - page);

where p = page.


Is this bug intentional to avoid overload or it's really a mistake?

PS: there is an obvious fix, I didn't attached to avoid you flaming me. 
:-)
    
-- 
  ricardo galli       GPG id C8114D34
