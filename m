Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292131AbSCPDvb>; Fri, 15 Mar 2002 22:51:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292881AbSCPDvN>; Fri, 15 Mar 2002 22:51:13 -0500
Received: from usfw01.photomask.com ([198.6.73.7]:30581 "EHLO
	yellow.photomask.com") by vger.kernel.org with ESMTP
	id <S292131AbSCPDvH> convert rfc822-to-8bit; Fri, 15 Mar 2002 22:51:07 -0500
From: John Helms <john.helms@photomask.com>
Date: Sat, 16 Mar 2002 04:34:36 GMT
Message-ID: <20020316.4343600@linux.local>
Subject: Re: bug (trouble?) report on high mem support
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
CC: "Randy.Dunlap" <rddunlap@osdl.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        linux-kernel@vger.kernel.org, Trice Jim <Jim.Trice@photomask.com>,
        Andmike@us.ibm.com
In-Reply-To: <21660000.1016236948@flay>
In-Reply-To: <Pine.LNX.4.33L2.0203151526250.14689-200000@dragon.pdx.osdl.net> <21660000.1016236948@flay>
X-Mailer: Mozilla/3.0 (compatible; StarOffice/5.1; Linux)
X-Priority: 3 (Normal)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin/Randy/Alan/Mike,

The readprofile output I sent earlier is pretty
accurate.  I performed the test right after a reboot
to the enterprise (64GB mem) kernel with a profile=2
boot option.  I then ran our program, which reads in
a 3.1GB file from an NFS mount, and outputs a 2.4GB file
in another format to the same NFS mount.  Networking
is achieved through an IBM Gigabit fiber card with 
Intel e1000 chipset, which we have downloaded the
latest source just to get it to work.  But network
throughput looks great.  Other programs using the 
NFS mounts work fine, so I'm pretty sure it's not
a network issue.

The smp kernel (no 64GB mem support) completed the
file conversion in 3.5 hours.  Previous attempts 
with the enterprise kernel (64GB mem support) had
to be aborted after 3 days and only started to write
the converted file to disk by then.  This application
does not run multi-threaded, but we will have 
multiple users running the program on separate
file conversions simultaneously.  Hence the need
for lots of memory.

I guess the main question at this point is whether
our hardware supports high memory, and then which 
patches or kernel upgrades can correct our problem.
If we upgrade the entire kernel, which release 
would you recommend for a stable production machine
with >4GB memory?  If there are swap improvements,
we also need whatever we can get in that area.


I don't know if this helps, but here is some info
from the /proc filesystem:


rrux01 23: more ioports
0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0070-007f : rtc
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
01f0-01f7 : ide0
02f8-02ff : serial(auto)
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(auto)
0700-070f : ServerWorks OSB4 IDE Controller
  0700-0707 : ide0
  0708-070f : ide1
0cf8-0cff : PCI conf1
2200-22ff : Adaptec AHA-294x / AIC-7884U
  2200-22fe : aic7xxx
2300-231f : Advanced Micro Devices [AMD] 79c970 [PCnet LANCE]
  2300-231f : PCnet/FAST III 79C975
4000-40ff : Adaptec 7899P
  4000-40fe : aic7xxx
4100-41ff : Adaptec 7899P (#2)
  4100-41fe : aic7xxx
4200-42ff : Adaptec 7892A
  4200-42fe : aic7xxx
rrux01 24: more iomem
00000000-0009cfff : System RAM
0009d000-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000ca000-000ca7ff : Extension ROM
000ca800-000d27ff : Extension ROM
000f0000-000fffff : System ROM
00100000-dfff937f : System RAM
  00100000-0025e40f : Kernel code
  0025e410-00277d3f : Kernel data
dfff9380-dfffffff : ACPI Tables
ec2d0000-ec2dffff : PCI device 8086:1001 (Intel Corporation)
ec2e0000-ec2fffff : PCI device 8086:1001 (Intel Corporation)
  ec2e0000-ec2fffff : e1000
ed7fe000-ed7fffff : PCI device 1014:01bd (IBM)
  ed7fe000-ed7fffff : ips
efbfd000-efbfdfff : Adaptec 7892A
efbfe000-efbfefff : Adaptec 7899P (#2)
efbff000-efbfffff : Adaptec 7899P
f0000000-f7ffffff : S3 Inc. Savage 4
feb00000-feb7ffff : S3 Inc. Savage 4
febfd000-febfdfff : ServerWorks OSB4/CSB5 OHCI USB Controller
  febfd000-febfdfff : usb-ohci
febfec00-febfec1f : Advanced Micro Devices [AMD] 79c970 [PCnet LANCE]
febff000-febfffff : Adaptec AHA-294x / AIC-7884U
fec00000-fec00fff : reserved
fee00000-fee00fff : reserved
fff80000-ffffffff : reserved
rrux01 25: ls -ld modules
-r--r--r--    1 root     root            0 Mar 15 20:52 modules
rrux01 26: more modules
iptable_mangle          2272   0 (autoclean) (unused)
iptable_nat            19280   0 (autoclean) (unused)
ip_conntrack           18544   1 (autoclean) [iptable_nat]
iptable_filter          2272   0 (autoclean) (unused)
ip_tables              11936   5 [iptable_mangle iptable_nat 
iptable_filter]
sg                     29552   0 (autoclean)
reiserfs              161360   1 (autoclean)
nfs                    83680   3 (autoclean)
lockd                  53744   1 (autoclean) [nfs]
sunrpc                 70000   1 (autoclean) [nfs lockd]
ide-cd                 27136   0 (autoclean)
cdrom                  28800   0 (autoclean) [ide-cd]
soundcore               4848   0 (autoclean)
autofs                 12064   2 (autoclean)
e1000                  62944   1
pcnet32                12368   0 (unused)
st                     27024   0 (unused)
usb-ohci               19360   0 (unused)
usbcore                54560   1 [usb-ohci]
ext3                   67728   8
jbd                    44480   8 [ext3]
ips                    39552  10
aic7xxx               114704   0 (unused)
sd_mod                 11584  10
scsi_mod               98512   5 [sg st ips aic7xxx sd_mod]   

>>>>>>>>>>>>>>>>>> Original Message <<<<<<<<<<<<<<<<<<

On 3/15/02, 6:02:28 PM, "Martin J. Bligh" <Martin.Bligh@us.ibm.com> 
wrote regarding Re: bug (trouble?) report on high mem support:


> From how I read his original description:

> > 2.  A program we use runs almost entirely in kernel
> > mode in a kernel compiled for large (>4GB) memory support.
> > Same program runs in user mode in a kernel only compiled
> > for smp support (4GB memory limit).  Top output shows only
> > ~5% cpu for user, ~95% for system and program runs VERY slow.
> > SMP kernel has ~60% user, ~40% system and program runs
> > acceptably.

> I assumed the problem occured when he switched from 4Gb support
> to 64Gb support ... am I just misreading this? So he should already
> be bouncing everything with 4Gb (which seems to work) around
> unless he has the high io stuff.

> The only thing that looked wierd in his profile was this:

> 54729 do_mmap_pgoff                             51.8267

> John, can you try "echo 2 > /proc/profile" just before you run your
> test, and then readprofile immediately your test stops? That'll zero
> the profile just before you start, and should make the output a little
> more "focused", and confirm that this function is what's eating the
> sys time.

> M.

> --On Friday, March 15, 2002 15:38:11 -0800 "Randy.Dunlap" 
<rddunlap@osdl.org> wrote:

> > Hi-
> >
> > If someone (Martin or Alan ?) hasn't already told you,
> > there is a block-highmem patch for 2.4.teens, so if you
> > can upgrade your kernel to 2.4.19-pre3, for example,
> > the block-highmem patch is at
> >   
http://www.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.19p
re3aa2/
> > file: 00_block-highmem-all-18b-7.gz
> >
> > Also, as suggested a day or two ago, you could profile the
> > kernel to see where it is spending time, although I'm not
> > sure how useful that would be.
> >
> > A third alternative for you is to apply the attached patch.
> > I applied it to 2.4.9 (it applies with a little "fuzz"),
> > but I haven't tested it on 2.4.9, just 2.4.teens.
> >
> > It counts bounce IOs, both normal IOs and swap IOs.
> > They can be displayed by printing /proc/stats .
> > This patch doesn't work with the block-highmem
> > patch applied -- I'm working on a different patch for that.
> >
> > This patch also prints (by major:minor) which device(s) are
> > causing bounce IO.  This printing could become excessive
> > for you, so don't hesitate to disable it (comment it out, or
> > let me know if you need help with it).
> >
> > Regards,
> > ~Randy
> >
> >
> > On Fri, 15 Mar 2002, John Helms wrote:
> >
> >| Alan,
> >|
> >| Ok, how do I go about determining that?  The machine
> >| I have is a brand-spankin' new IBM x-series 350 with
> >| 4 900MHz Xeon processors.  The system bios can
> >| recognize all of the 16320MB of memory at startup.
> >| If those patches work, it will save our butts as
> >| we have a major conversion project that hinges on
> >| this.
> >|
> >| Thanks,
> >| jwh
> >|
> >| >>>>>>>>>>>>>>>>>> Original Message <<<<<<<<<<<<<<<<<<
> >|
> >| On 3/15/02, 2:30:22 PM, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote 
regarding
> >| Re: bug (trouble?) report on high mem support:
> >|
> >|
> >| > > Here is a top output.  We have 16Gb of ram.
> >| > > I have also tried a 2.4.9-31 enterprise=20
> >| > > kernel rpm from RedHat with the same=20
> >| > > results.
> >|
> >| > Ok that would make sense. Next question is do you have an I/O 
controller
> >| > that can use all the 64bit address space on the PCI bus ?
> >|
> >| > What is happening is that you are using a lot of CPU copying 
buffers down
> >| > into lower memory to transfer to/from disk - as well probably as 
that
> >| > causing a lot of competition for low memory. If your I/O controller 
can
> >| hit
> >| > the full 64bit space there are some rather nice test patches that 
should
> >| > completely obliterate the problem.
> >|
> >| > Alan



