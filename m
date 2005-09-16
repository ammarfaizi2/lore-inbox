Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161135AbVIPImQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161135AbVIPImQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 04:42:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161136AbVIPImQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 04:42:16 -0400
Received: from aml46.internetdsl.tpnet.pl ([83.17.67.46]:59129 "HELO
	aml46.internetdsl.tpnet.pl") by vger.kernel.org with SMTP
	id S1161135AbVIPImP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 04:42:15 -0400
Date: Fri, 16 Sep 2005 10:42:07 +0200
From: Lukasz Stelmach <stlman@poczta.fm>
To: linux-kernel@vger.kernel.org
Subject: resource limits does not work?
Message-ID: <20050916084206.GA19606@vlana.p.telmark.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.4.2.1i
X-Mail-Editor: Vim version 5.8.3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings All.

Is there anything you think I should know about setrlimit that is not
mentioned in setrlimit(2) manual that makes the malloc(3) succeed 
in the code below? It fails when r.rlim_cur is less than 137840.

#include <sys/time.h>
#include <sys/resource.h>
#include <unistd.h>

int main(int ac, char* av[]) {
        struct rlimit r;
        r.rlim_cur = 137840;
        r.rlim_max = RLIM_INFINITY;
        setrlimit(RLIMIT_DATA, &r);

        char* a=malloc(6000000);
        perror("malloc");
        return 0;
}

What is more interesting is that dnscache from djbdnspackage succeeds to start
up with rlim_cur to be 0.

$ uname -a
Linux vlana 2.6.11 #1 SMP Fri Mar 4 17:35:07 CET 2005 i686 unknown unknown GNU/Linux

cheers.
PS. please CC, not a subscriber.
-- 
Miłego dnia
>Łukasz<
