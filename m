Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132367AbRATT5C>; Sat, 20 Jan 2001 14:57:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132365AbRATT4x>; Sat, 20 Jan 2001 14:56:53 -0500
Received: from Earth.nistix.com ([209.140.42.210]:19334 "EHLO Earth.nistix.com")
	by vger.kernel.org with ESMTP id <S132222AbRATT4h>;
	Sat, 20 Jan 2001 14:56:37 -0500
Message-ID: <3A69ED72.7030101@nistix.com>
Date: Sat, 20 Jan 2001 13:56:34 -0600
From: James Brents <James@nistix.com>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.0 i686; en-US; m18) Gecko/20010110
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Oops in 2.2.17
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Using 2.2.17 kernel that is standard other than the bridging firewall 
patch, this Oops happened while setting up tripwire - it was scanning 
the disk and then locked up. As its purely a remote machine, I am only 
able to go off of the logs in syslogd. Below is the ksymoops report. If 
im leaving anything out, please let me know.
While its somewhat relevant, it will also oops when doing a shutdown -h 
but I added the option for buggy chipsets, but havnt tested it, as its a 
server and shouldnt really be shutdown anyhow.

Ksymoops report:

ksymoops 2.3.4 on i586 2.2.17.  Options used
      -v /usr/src/linux/vmlinux (specified)
      -k /proc/ksyms (default)
      -l /proc/modules (default)
      -o /lib/modules/2.2.17/ (default)
      -m /usr/src/linux/System.map (default)

Jan 20 13:14:59 Venus kernel: current->tss.cr3 = 00101000, %%cr3 = 00101000
Jan 20 13:14:59 Venus kernel: *pde = 00000000
Jan 20 13:14:59 Venus kernel: Oops: 0000
Jan 20 13:14:59 Venus kernel: CPU:    0
Jan 20 13:14:59 Venus kernel: EIP:    0010:[show_registers+653/704]
Jan 20 13:14:59 Venus kernel: EFLAGS: 00010046
Jan 20 13:14:59 Venus kernel: eax: 00000000   ebx: 00000000   ecx: 
e86e2fe2   edx: c1c78000
Jan 20 13:14:59 Venus kernel: esi: 28181f68   edi: c1fb0000   ebp: 
c2800000   esp: c1faff2c
Jan 20 13:14:59 Venus kernel: ds: 0018   es: 0018   ss: 0018
Jan 20 13:14:59 Venus kernel: Process kswapd (pid: 5, process nr: 5, 
stackpage=c1faf000)
Jan 20 13:14:59 Venus kernel: Stack: e86e2fe2 00000e00 c0206d2e c01bee9a 
c1fae1c1 00000e00 c1faffd4 c1fae000
Jan 20 13:14:59 Venus kernel:        c021961c c021961c e86e2fe2 00010286 
e86e2fe3 c3000000 c0108d58 c1faffb0
Jan 20 13:14:59 Venus kernel:        c01bb776 c01bd16e 00000000 00000000 
c010dfc0 c01bd16e c1faffb0 00000000
Jan 20 13:15:00 Venus kernel: Call Trace: [tvecs+7194/13344] 
[<c3000000>] [die+48/56] [error_table+2646/9568] [error_table+9294/9568] 
[do_page_fault+708/944] [error_table+9294/9568]
Jan 20 13:15:00 Venus kernel: Code: 8a 04 0b 89 44 24 38 50 68 6e b7 1b 
c0 e8 91 9d 00 00 83 c4
Using defaults from ksymoops -t elf32-i386 -a i386

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
    0:   8a 04 0b                  mov    (%ebx,%ecx,1),%al
Code;  00000003 Before first symbol
    3:   89 44 24 38               mov    %eax,0x38(%esp,1)
Code;  00000007 Before first symbol
    7:   50                        push   %eax
Code;  00000008 Before first symbol
    8:   68 6e b7 1b c0            push   $0xc01bb76e
Code;  0000000d Before first symbol
    d:   e8 91 9d 00 00            call   9da3 <_EIP+0x9da3> 00009da3 
Before first symbol
Code;  00000012 Before first symbol
   12:   83 c4 00                  add    $0x0,%esp


System information:
[syonic@Venus syonic]$ cat /proc/cpuinfo
processor 
: 0
vendor_id 
: GenuineIntel
cpu family	: 5
model 
	: 2
model name	: Pentium 75 - 200
stepping 
: 5
cpu MHz		: 100.230
fdiv_bug 
: no
hlt_bug 
	: no
sep_bug 
	: no
f00f_bug 
: yes
coma_bug 
: no
fpu 
	: yes
fpu_exception 
: yes
cpuid level	: 1
wp 
	: yes
flags 
	: fpu vme de pse tsc msr mce cx8
bogomips 
: 199.88

Its a SOYO 5ED board with ETEQ 82C662X chipset (the manual is available 
at http://www.soyousa.com/manuals/586new/m5ed20f.pdf if your really 
interested in every part of the board)
The machine is serving as a firewall for my internal network. Its only 
been running for a few days so far with no problems.


If any other information is needed at all, please let me know. I am 
unable to reproduce it when using tripwire again, So im not sure how to 
reproduce this, but I'm open to any suggestions. Also, the bridging 
firewall patch (which I would like to see in 2.4) is available at
http://ac2i.tzo.com/bridge_filter/linux_brfw_2.2.17.diff  in case your 
wondering what I've done to my kernel, but I dont think its too 
relevant, but im not a kernel developer. Again, let me know if theres 
anything I can do to further trace this.

--
James Brents
James@nistix.com

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
