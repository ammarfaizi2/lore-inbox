Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264872AbSLBTUY>; Mon, 2 Dec 2002 14:20:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264878AbSLBTUY>; Mon, 2 Dec 2002 14:20:24 -0500
Received: from web13204.mail.yahoo.com ([216.136.174.189]:27249 "HELO
	web13204.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S264872AbSLBTUX>; Mon, 2 Dec 2002 14:20:23 -0500
Message-ID: <20021202192553.87887.qmail@web13204.mail.yahoo.com>
Date: Mon, 2 Dec 2002 19:25:53 +0000 (GMT)
From: =?iso-8859-1?q?Kurt=20Johnson?= <gorydetailz@yahoo.co.uk>
Subject: small doubt about fair-scheduler patch
To: riel@conectiva.com.br
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Im using your fair scheduler patch (2.4.19-fairsched),
applied on top of 2.4.20-rmap15a+read_latency2, and
everything seems great. However, I have one small
doubt, ps output seems a little strange, some
processes appear to be out of order. To illustrate,
here's the output of ps. Im wondering, is this normal?

bash-2.0.5b# ps -eo pid,ppid,user,command
  PID  PPID USER     COMMAND
    3     1 root     [ksoftirqd_CPU0]
    2     1 root     [keventd]
    5     1 root     [kscand]
    6     1 root     [bdflush]
    8     1 root     [kreiserfsd]
  410     1 root     /sbin/dhcpcd eth0
  551     1 root     [eth1]
  613     1 root     klogd -x
  627     1 root     sshd
    1     0 root     init [3]
  682   627 root     sshd
  685   684 kurt     -bash
  760   685 root     su -
  799     1 root     xinetd
  604     1 root     syslogd -m 0
  820     1 snmp     /usr/sbin/snmpd
  841     1 root     logger -t safe_mysqld
  840     1 root     /bin/sh /usr/bin/safe_mysqld 
  870   840 mysql    /usr/sbin/mysqld
    4     1 root     [kswapd]
  894   885 httpd    /usr/sbin/httpd -DSSL
  893   885 httpd    /usr/sbin/httpd -DSSL
  885     1 root     /usr/sbin/httpd -DSSL
  898   885 httpd    /usr/sbin/httpd -DSSL
  680     1 root     portsentry -audp
  681     1 root     portsentry -atcp
  665     1 root     crond
    7     1 root     [kupdated]
  761   760 root     -bash
  684   682 kurt     sshd
 1003   761 root     ps -eo pid,ppid,user,command

Without the fairsched patch, ps output is normal, eg,
init is always the first process listed, all kernel
threads appear at the top (notice kswapd and kupdated
near the bottom), and processes with lower pids never
appear after others with higher (eg, portsentry is 680
and was started before httpd which is 898, yet it
still appears after it). Im just wondering, is this
purely aesthetically or is there something fishy?

Regards,

//kj

__________________________________________________
Do You Yahoo!?
Everything you'll ever need on one web page
from News and Sport to Email and Music Charts
http://uk.my.yahoo.com
