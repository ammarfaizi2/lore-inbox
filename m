Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291787AbSCSTgI>; Tue, 19 Mar 2002 14:36:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291948AbSCSTf6>; Tue, 19 Mar 2002 14:35:58 -0500
Received: from web20501.mail.yahoo.com ([216.136.226.136]:25666 "HELO
	web20501.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S291787AbSCSTfy>; Tue, 19 Mar 2002 14:35:54 -0500
Message-ID: <20020319193553.25896.qmail@web20501.mail.yahoo.com>
Date: Tue, 19 Mar 2002 20:35:53 +0100 (CET)
From: =?iso-8859-1?q?willy=20tarreau?= <wtarreau@yahoo.fr>
Subject: Re: Linux 2.4.19pre3-ac2           
To: alan@lxorguk.ukuu.org.uk, jdthood@mail.com
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

Well, I discovered today that reading /proc/bus/pnp/0e
oopsed on me on 2.4.19p2 with the 2.4.17 pnpbios
patch (+lots of other patches that don't help to
make easy reports). Didn't try without pnpbios yet.
lspnp -v triggers it very easily. 0e is the PS2 port
(PNP0f13). I had this on at least two P3's with
different hardware and bioses.

So I tried plain 2.4.19-pre3-ac2, and now it
reboots immediately. I've tried 3 versions
down to 2.4.10-ac12 which segfaults too.
Other pnp entries can be read perfectly
(can provide dump if it helps).

I will send the ksymoops report from 2.4.19p2
with 2.4.17 pnpbios when I get home (because
I'd like to get a real email client - elm). At least
at the moment, I can resume the end of the
report to this :

>>EIP; 0000879a Before first symbol   <=====
c014daf8 <get_new_inode+48/1a4>
c014dbca <get_new_inode+11a/1a4>
c021aa2c <__pnp_bios_get_dev_node+110/16c>
c0120000 <sys_capset+238/288>
c0120018 <sys_capset+250/288>
c021aa9e <pnp_bios_get_dev_node+16/34>
c021bbe0 <proc_read_node+44/88>
c0156f0a <proc_file_read+f2/1bc>
c0139326 <sys_read+8e/110>
c010744a <tracesys+1e/22>

Please note that it doesn't really affect me
because I don't need pnpbios on these hosts,
but some people may be concerned about the
security risk since the entry is world-readable.
I'm just always trying to build better kernels ;-)

Hope this helps. I'll be able to do more tests
if other people cannot reproduce.

Cheers,
Willy


___________________________________________________________
Do You Yahoo!? -- Une adresse @yahoo.fr gratuite et en français !
Yahoo! Mail : http://fr.mail.yahoo.com
