Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317072AbSFQWNe>; Mon, 17 Jun 2002 18:13:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317073AbSFQWNd>; Mon, 17 Jun 2002 18:13:33 -0400
Received: from isis.telemach.net ([213.143.65.10]:47114 "HELO
	isis.telemach.net") by vger.kernel.org with SMTP id <S317072AbSFQWNc>;
	Mon, 17 Jun 2002 18:13:32 -0400
Date: Tue, 18 Jun 2002 00:16:23 +0200
From: Jure Pecar <pegasus@telemach.net>
To: linux-kernel@vger.kernel.org
Subject: 2.4.19-pre10aa2: BUG at exit.c:530
Message-Id: <20020618001623.5b4b63db.pegasus@telemach.net>
Organization: Select Technology 
X-Mailer: Sylpheed version 0.7.6 (GTK+ 1.2.10; i386-redhat-linux)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 boundary="/DrpMN(GZM=.MaCq"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--/DrpMN(GZM=.MaCq
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi all,

I'm getting the following oops every now and then:

ksymoops 2.4.4 on i686 2.4.19-pre10.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.19-pre10/ (default)
     -m /boot/System.map-2.4.19-pre10 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Warning (compare_maps): ksyms_base symbol
set_cpus_allowed_R__ver_set_cpus_allowed not found in System.map. 
Ignoring ksyms_base entry
kernel BUG at exit.c:530!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c011dedd>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246
eax: cf382000   ebx: c281b200   ecx: 00000000   edx: 00000000
esi: cf382000   edi: 00000000   ebp: cf382000   esp: cf383fa8
ds: 0018   es: 0018   ss: 0018
Process slapd (pid: 5249, stackpage=cf383000)
Stack: cf382000 401cef1c 00000000 bfff6bc4 c011df12 00000000 c0108b5b
00000f21 
       bedffe38 bedffe40 080b67fc bedfff24 080b6724 00000000 0000002b
0000002b 
       00000078 4011a13e 00000023 00000292 bedffe38 0000002b 
Call Trace: [<c011df12>] [<c0108b5b>] 
Code: 0f 0b 12 02 40 34 28 c0 e9 5d fd ff ff 89 f6 8b 44 24 04 85 

>>EIP; c011dedd <do_exit+2f9/308>   <=====
Trace; c011df12 <sys_exit+e/10>
Trace; c0108b5b <system_call+2f/34>
Code;  c011dedd <do_exit+2f9/308>
00000000 <_EIP>:
Code;  c011dedd <do_exit+2f9/308>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c011dedf <do_exit+2fb/308>
   2:   12 02                     adc    (%edx),%al
Code;  c011dee1 <do_exit+2fd/308>
   4:   40                        inc    %eax
Code;  c011dee2 <do_exit+2fe/308>
   5:   34 28                     xor    $0x28,%al
Code;  c011dee4 <do_exit+300/308>
   7:   c0 e9 5d                  shr    $0x5d,%cl
Code;  c011dee7 <do_exit+303/308>
   a:   fd                        std    
Code;  c011dee8 <do_exit+304/308>
   b:   ff                        (bad)  
Code;  c011dee9 <do_exit+305/308>
   c:   ff 89 f6 8b 44 24         decl   0x24448bf6(%ecx)
Code;  c011deef <complete_and_exit+3/18>
  12:   04 85                     add    $0x85,%al


The system is a 4way xeon with 2gb ram, running sendmail+openldap+cyrus,
gcc version egcs-2.91.66. This is the fourth such oops in six days and
it always happened on slapd process. Before this kernel i was running
2.4.18rc2aa2 and everything was smooth, except the ext3 problem (that's
why i want to upgrade). Only modification i did to this kernel was
adding the ext3 0.9.18 patch.

Any ideas? Altough the box keeps on crunching mails, i'd sleep better
without these oopsen occuring.

-- 


Jure Pecar

--/DrpMN(GZM=.MaCq
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)

iD8DBQE9Dl+5OHUMrcOSg+8RArP2AKDayo/+XWOUhEsdkgKjJVDHFOmCiQCgl+n+
nvmPJZOGOUhcBpmimnEoz0s=
=Ud0Y
-----END PGP SIGNATURE-----

--/DrpMN(GZM=.MaCq--

