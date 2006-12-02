Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162436AbWLBA4M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162436AbWLBA4M (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 19:56:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162441AbWLBA4M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 19:56:12 -0500
Received: from mail1.key-systems.net ([81.3.43.253]:25234 "HELO
	mailer2-1.key-systems.net") by vger.kernel.org with SMTP
	id S1162436AbWLBA4K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 19:56:10 -0500
Message-ID: <4570CF26.8070800@scientia.net>
Date: Sat, 02 Dec 2006 01:56:06 +0100
From: Christoph Anton Mitterer <calestyo@scientia.net>
User-Agent: Icedove 1.5.0.8 (X11/20061124)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: data corruption with nvidia chipsets and IDE/SATA drives // memory
 hole mapping related bug?!
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

Perhaps some of you have read my older two threads:
http://marc.theaimsgroup.com/?t=116312440000001&r=1&w=2 and the even
older http://marc.theaimsgroup.com/?t=116291314500001&r=1&w=2

The issue was basically the following:
I found a severe bug mainly by fortune because it occurs very rarely.
My test looks like the following: I have about 30GB of testing data on
my harddisk,... I repeat verifying sha512 sums on these files and check
if errors occur.
One test pass verifies the 30GB 50 times,... about one to four
differences are found in each pass.

The corrupted data is not one single completely wrong block of data or
so,.. but if you look at the area of the file where differences are
found,.. than some bytes are ok,.. some are wrong,.. and so on (seems to
be randomly).

Also, there seems to be no event that triggers the corruption,.. it
seems to be randomly, too.

It is really definitely not a harware issue (see my old threads my
emails to Tyan/Hitachi and my "workaround" below. My system isn't
overclocked.



My System:
Mainboard: Tyan S2895
Chipsets: Nvidia nforce professional 2200 and 2050 and AMD 8131
CPU: 2x DualCore Opterons model 275
RAM: 4GB Kingston Registered/ECC
Diskdrives: IBM/Hitachi: 1 PATA, 2 SATA


The data corruption error occurs on all drives.


You might have a look at the emails between me and Tyan and Hitachi,..
they contain probalby lots of valuable information (especially my
different tests).



Some days ago,.. an engineer of Tyan suggested me to boot the kernel
with mem=3072M.
When doing this,.. the issue did not occur (I don't want to say it was
solved. Why? See my last emails to Tyan!)
Then he suggested me to disable the memory hole mapping in the BIOS,...
When doing so,.. the error doesn't occur, too.
But I loose about 2GB RAM,.. and,.. more important,.. I cant believe
that this is responsible for the whole issue. I don't consider it a
solution but more a poor workaround which perhaps only by fortune solves
the issue (Why? See my last eMails to Tyan ;) )



So I'd like to ask you if you perhaps could read the current information
in this and previous mails,.. and tell me your opinions.
It is very likely that a large number of users suffer from this error
(namely all Nvidia chipset users) but only few (there are some,.. I
found most of them in the Nvidia forums,.. and they have exactly the
same issue) identify this as an error because it's so rare.

Perhaps someone have an idea why disabling the memhole mapping solves
it. I've always thought that memhole mapping just moves some address
space to higher addreses to avoid the conflict between address space for
PCI devices and address space for pyhsical memory.
But this should be just a simple addition and not solve this obviously
complex error.



Lots of thanks in advance.

Best wishes,
Chris.




#########################################################################
### email #1 to Tyan/Hitachi                                          ###
#########################################################################

(sorry for reposting but the AMD support system requires to add some keywords in
the subject, and I wanted to have the correct subject for all other parties
(Tyan and Hitachi) too, so that CC'ing would be possible for all.

Hi.

I provide this information to:
- Tyan (support@tyan.de) - Mr. Rodger Dusatko
- Hitachi (support_de@hitachigst.com , please add the GST Support
Request #627-602-082-5 in the subject) Mr. Schledz)
- and with this email for the first time to AMD tech.support@amd.com
(for the AMD people: please have a look at the information at the very
end of this email first,... there you'll find links where you can read
the introduction and description about the whole issue).

It might be useful if you contact each other (and especially nvidia
which I wasn't able to contact myself),.. but please CC me in all you
communications.
Also, please forward my emails/information to your responsible technical
engineers and developers.

Please do not ignore this problem:
- it existing,
- several users are experiencing it (thus this is not a single failure
of my system),
- it can cause severe data corruption (which is even more grave, as the
a user won't notice it throught error messages) and
- it happens with different Operating Systems (at least Linux and Windows).




This is my current state of testing. For further information,.. please
do not hesitate to ask.
You'll find old information (included in my previous mails or found at
the linux-kernel mailinglist thread I've included in my mails) at the end.

- In the meantime I do not use diff any longer for my tests, simply
because it takes much longer than to use sha512sums to verify
dataintegrity (but this has not effect on the testing or the issue
itself, it just proves that the error is not in the diff program).

- I always test 30GB insteat of 15

- As before I'm still very sure, that the following components are fully
working and not damaged (see my old mails or lkml):
CPUs => due to extensive gimps/mprime torture tests
memory => due to extensive memtest86+ tests
harddisks => because I use three different disks (SATA-II and PATA) (but
all from IBM/Hitachi or Hitachi) and I did extensive badblock scans
temperature should be ok in my system => proper chassis (not any of the
chep ones) with several fans, CPUs between 38 °C an 45°C, System ambient
about 46°C, videocard, between 55° and 88°C (when under full 3D use),...
the chipsetS (!) don't have temperature monitoring,.. and seem to be
quite hot, but according Tyan this is normal.


Ok now my current state:
- I found (although it was difficult) a lot of resource in the internet
where users report about the same or a very similar problem using the
same hardware components. Some of them:
http://forums.nvidia.com/index.php?showtopic=8171&st=0
http://forums.nvidia.com/index.php?showtopic=18923
http://lkml.org/lkml/2006/8/14/42 (see http://lkml.org/lkml/2006/8/15/109)
Note that I've opened a thread at the nvidia forums myself:
http://forums.nvidia.com/index.php?showtopic=21576

All of them have in common, that the issue is/was not a hardware failure
and it seems that none of them was able to reproduce the failure.


- As far as I understand the Tyan S2895 mainboard manual
ftp://ftp.tyan.com/manuals/m_s2895_101.pdf on page 9,... both the IDE
and SATA are connected to the Nvidia nforce professional 2200,.. so this
may be nvidia related
(If anyone of you has the ability to contact nvidia,.. please do so and
send them all my information (also the old one). It seems that it's not
easily possible to contact them for "end-users")

- I tried different cable routings in my chassis (as far as this was
possible) which did not solve the problem.
I also switched of all other devices in my rooms that might produce
electro-magnetic disturbances....
thus electro-magnetic disturbances are unlikely.

- I found the errata for the AMD 8131 (which is on of my chipsets):
www.amd.com/us-en/assets/content_type/white_papers_and_tech_docs/26310.pdf
Please have a look at it (all the issues) as some might be responsible
for the whole issue.

- I tried to use older BIOS versions (1.02 and 1.03) but all of them
gave me an OPROM error (at bus 12 device 06 function 1) and despite of
that booting,.. the problem still exists.
According to Linux's dmesg this is:

12:06.0 SCSI storage controller: LSI Logic / Symbios Logic 53c1030 PCI-X
Fusion-MPT Dual Ultra320 SCSI (rev 07)
12:06.1 SCSI storage controller: LSI Logic / Symbios Logic 53c1030 PCI-X
Fusion-MPT Dual Ultra320 SCSI (rev 07)

- I tried with 8131 Errata 56 PCLK (which actualy disables the AMD
Errata 56 fix) but the issue still exists

- I activated my BIOS's Spread Spectrum Option (although it is not
described what it does).
Is this just for harddisks? And would I have to activate SpredSpectrum
at the Hitachi Feature Tools, too, for having an effect?

- I tried everything with the lowest possible BIOS settings,.. which
solved nothing.

- According to the information found in the threads at the nvidia boards
(see the links above)... this may be a nvidia-Hitachi nvidia-Maxtor (and
even other manufracturers of HDDs) related problem.
Some even claimed that deactivation of Native Command Queueing (NCQ)
helped,.. BUT only for a limited time.
But as far as I know, Linux doesn't support NCQ at all (at the moment).


Thank you very much for now.
Best wishes,
Christoph Anton Mitterer.


----------------------------
Old information:
As a reminder my software/hardware data:

CPU: 2x DualCore Opteron 275
Mainboard: Tyan Thunder K8WE (S2895)
Chipsets: Nvidia nForce professional 2200, Nvidia nForce professional
2050, AMD 8131
Memory: Kingston ValueRAM 4x 1GB Registered ECC
Harddisks: 1x PATA IBM/Hitachi, 2x SATA IBM/Hitachi
Additional Devices/Drives: Plextor PX760A DVD/CD, TerraTec Aureon 7.1
Universe soundcard, Hauppage Nova 500T DualDVB-T card.
Distribution: Debian sid
Kernel: self-compiled 2.6.18.2 (see below for .config) with applied EDAC
patches

The system should be cooled enough so I don't think that this comes from
overheating issues. Nothing is overclocked.


The issue was:

For an in depth description of the problem please have a look at the
linux-kernel mailing list.
The full, current thread:
http://marc.theaimsgroup.com/?t=116312440000001&r=1&w=2

(You'll find there my system specs, too.)


An older thread with the same problem, but where I thougt the problem is
FAT32 related (anyway, might be interesting, too):
http://marc.theaimsgroup.com/?t=116291314500001&r=1&w=2
#########################################################################
### email #2 to Tyan/Hitachi                                          ###
#########################################################################

Hi Mr. Dusatko, hi Mr. Ebner.


Rodger Dusatko - Tyan wrote:

> > Thanks so much for your e-mail.
>   
Well I have to thank you for your support, too :-)


> > You seem to have tried many different tests.
> >   
>   
Dozens ^^


> > If I understand the problem correctly, when you use the on-board SATA, you 
> > are receiving corrupted data.
> >   
>   
It happens with the onboard IDE, too !!!! This sounds reasonable as both
IDE and SATA are connected to the nforce 2200.
If you read the links to pages where other people report about the same
problem (especially at the Nvidia forums) you'll see that others think
that this is nforce related, too.

I established contact with some of them and most think that this may
(but of course there is no definite proof for this) related to a
nforce/disk manufracturer combination. So all of them report for example
that the error occurs with nforce/Hitachi.
Some of them think that it might be NCQ related (did you read the NCQ
related parts of my last email? As far as I can see NCQ will be added in
the kernel for sata_nv in 2.6.19).
Both of this sounds somewhat strange to me...
For my understanding of computer technology I would assume that this
should be a general harddisk error,.. and not only Hitachi or e.g.
Maxtor related.

(I didn't test it with the onboard SCSI, as I don't have any SCSI drives.)
Not that




> > Sometimes we have solved this problem by simply readjusting bios settings.
> >   
>   
Does this mean that you were able to reproduce the problem?



> > Please try the following:
> >
> > in the Linux boot prompt, please try (mem=3072M). This will show whether it 
> > might be a problem related to the memory hole.
> > or use only 2gb of memory.
> >
> >   
>   
I'm going to test this in a few minutes (althoug I think I did already a
similar test)...
Anyway from a theoretical point of view it sounds very unlikely to me,
that this is a memory related issue at all. Not only because of my
memtest86+ test,.. but also because of the way the linux kernel works in
that area.


> > If it is a memory hole problem, you should have (with Linux) the following 
> > settings:
> >   
>   
My current memhole seetings are these (the ones that I use under
"normal" production):
IOMMU -> enabled
IOMMU -> 64 MB
Memhole -> AUTO
mapping -> HARDWARE

Other memory settings

-> Node Memory Interleave -> enabled
-> Dram Bank Interleave -> enabled
-> MTTR Mapping -> discrete
-> Memory Hole
-> Memory Hole mapping -> enabled
-> Memory Config
-> Memory Clock DDR400
-> Swizzle memory banks enabled




> > CMOS reset (press CMOS Clear button for 20 seconds).
> > Go into Bios -> Set all values to default (F9)
> > Main -> Installed O/S -> Linux
> > Advanced -> Hammer Config
> > -> Node Memory Interleave -> disabled
> > -> Dram Bank Interleave -> disabled
> > -> MTTR Mapping -> discrete
> > -> Memory Hole
> > -> Memory Hole mapping -> Disabled
> > -> Memory Config
> > -> Memory Clock DDR333
> > -> Swizzle memory banks disabled
> >   
>   
I've already checked excatly this setting ;) expect that I used
DDR400,... could that make any difference?


> > You might try SATA HDDs from another manufacturer.
> >   
>   
I'm already trying to do so but currently none of my friends was able to
borrow me any devices,... I'm also going to check the issue with other
operating systems (at least if I find any that support the Nvidia
chipsets at all),.. maybe some *BSD or OpenSolaris.



> > Also, I have a newer beta bios version available.
> >
> > ftp://ftp.tech2.de/boards/28xx/2895/BIOS/ -> 2895_1047.zip you might want to 
> > try.
> >   
>   
Please don't understand me wrong,... I still would like you to help and
investigate in that issue... but currently I think (although I may be
wrong) that this could be harddisk firmware related.
So what _excatly_ did you change in that version,.. or is it just a
crappy solution or workaround,...?



Any idea about that spread spectrum option?:

> > - I activated my BIOS's Spread Spectrum Option (although it is not
> > described what it does).
> > Is this just for harddisks? And would I have to activate SpredSpectrum
> > at the Hitachi Feature Tools, too, for having an effect?
> >   
>   

Thanks so far.

Chris.
#########################################################################
### email #3 to Tyan/Hitachi                                          ###
#########################################################################

Rodger Dusatko - Tyan wrote:

> > Hello Christoph,
> >
> > another customer having data corruption problems said by entering the 
> > command mem=3072M he no longer has data corruption problems.
> >
> > Please let me know as soon as possible, that I might know how to help 
> > further.
> >   
>   
I just finished my test....
Used my "old" BIOS settings (not the one included in you mail)... but
set mem=3072M.
It seems (although I'm not yet fully convinced as I've already had cases
where an error occured after lots of sha512-passes) that with mem=3072M
_no error occures_

But of course I get only 2GB ram (of my 4GB which I wanted to upgrad to
even more memory in the next months).
So just to use mem=3072M is not acceptable.

And I must admit that I have strong concerns about the fact that memhole
settings are a proper fix for that.
Of course I'd be glad if I could fix that... but from my own large
system programming experience I know that there are many cases where a
fix isn't really a fix for a problem,... but solves the problem in
conjunction with other errors (that are not yet found).


I'd be glad if you could give me better explanation of the
memhole-solution (and especially how to solve it without mem=3072M
because I'd like to have my full memory) ... because I'd like to fully
understand the issue to secure that it is really fixed or not.

I'll test you beta BIOS tomorrow and report my results.

If you whish I could also call you via phone (just give me your phone-#).

Thanks in advance,
Chris.
#########################################################################
### email #4 to Tyan/Hitachi                                          ###
#########################################################################
One thing I forgot,...
Although using it very very rarely,.. there are some cases where I have
to use M$ Windows.... and afaik,.. you cannot tell windows something
like mem=3072M
So it wouldn't solve that for Windows.


Chris.
#########################################################################
### email #5 to Tyan/Hitachi                                          ###
#########################################################################
Dear Mr. Dusatko, Mr. Ebner and dear sir at the Hitachi GST Support.

I'd like to give you my current status of the problem.

First of all AMD didn't even answer until now, the same applies for my
request at Nvidias knowledge base,... says something about these
companies I think.

For the people at Hitachi: With the advice of Mr. Dusatko from Tyan I
was able to workaround the problem:

Rodger Dusatko - Tyan wrote:

> > as I mentioned earlier, you can do some of these memory hole settings
> > : (for
> > Linux)
>   
>>> >>> Go into Bios -> Set all values to default (F9)
>>> >>> Main -> Installed O/S -> Linux
>>> >>> Advanced -> Hammer Config
>>> >>> -> Node Memory Interleave -> disabled
>>> >>> -> Dram Bank Interleave -> disabled
>>> >>> -> MTTR Mapping -> discrete
>>> >>> -> Memory Hole
>>> >>> -> Memory Hole mapping -> Disabled
>>> >>> -> Memory Config
>>> >>> -> Memory Clock DDR333
>>> >>> -> Swizzle memory banks disabled
>>>       
The above settings for the BIOS actually lead to a system that did not
make any errors during one of my complete tests (that is verifying
sha512sums 50 times on 30 GB of data).


Actually I seems to depend only on one of the above settings: Memory
hole mapping.
Currently I'm using the following:
Main -> Installed O/S -> Linux
Advanced -> Hammer Config
-> Node Memory Interleave -> Auto
-> Dram Bank Interleave -> Auto
-> MTTR Mapping -> discrete
-> Memory Hole
-> Memory Hole mapping -> Disabled
-> Memory Config
-> Memory Clock->DDR400
->Swizzle memory banks -> Enabled
And still no error occurs.
But as soon as I set Memory Hole mapping to one of the other values
(Auto, Hardware or Software),.. the error occurs.
(Especially for Tyan: Note that when using Software Node Memory
Interleave is always automatically set to Disabled after reboot, while
when using Harware, Auto works - perhaps a bug?)



Ok,.. now you might think,... problem solved,.. but it is defenitely not:

1) Memory Hole mapping costs me 2GB of my 4GB RAM (which are unusable
because of the memory hole),.. this is not really acceptable.
The beta BIOS Mr. Dusatko from Tyan gave might solve this, but I wasn't
able to test this yet.


2) But even it this would solve the problem I'm still very concerned and
encourage especially the people at Hitachi to try to find another reason.
Why? Because I cannot imagine how the memory hole leads to the wole issue:
- The memory hole is a quite simple process where the BIOS / Hardware
remaps to some portions of physical RAM to higher areas,.. to give the
lower areas to PCI devices that make uses of mmap.
Even if there would be an error,... that would not only affect IDE/SATA
but also CD/DVD/SCSI drives and any other memory operations at all.
AND there would be complete block that would be corrupted,.. not only
several bytes (remember: I've reportet that in a currupted block some
bytes are ok,.. some are note,... and so on).

-If you look at the board description
(ftp://ftp.tyan.com/manuals/m_s2895_101.pdf page 9) you see that both
IDE and SATA are connected to the nforce professional 2200, right?
Why should the memhole settings affect only the IDE/SATA drives? If
there was an error in the memory controller it would affect every memory
operation in the system (see above) because the memory controller is not
onboard,.. but integrated in the Operton CPUs. (This is also the reason
why, if the memory controller would have design errors, not only people
using nvidia chipsets have this problem,.. which is apparently the case.)

-Last but not least,.. (as also noted above) the errors are always like
the following: not a complete block is corrupted but just perhaps half
of all its bytes (in any order). Could this come from the simple memory
hole remapping???? In my opinion, definitely not.


So I think "we" are not yet finished with work.
- I ask the Hitachi people to continue their work (or start with it ;) )
in taking a special look at their firmware and how it interoperates with
nforce chipsets.
I found (really) lots of reports where people tells that this issue has
been resolved by firmware upgrades of their vendor (especially for
Maxtor devices).
Nvidia itself suggests this:
http://nvidia.custhelp.com/cgi-bin/nvidia.cfg/php/enduser/std_adp.php?p_faqid=768&p_created=1138923863&p_sid=9qSJ8Yni&p_accessibility=0&p_redirect=&p_lva=&p_sp=cF9zcmNoPSZwX3NvcnRfYnk9JnBfZ3JpZHNvcnQ9JnBfcm93X2NudD00MzImcF9wcm9kcz0mcF9jYXRzPSZwX3B2PSZwX2N2PSZwX3NlYXJjaF90eXBlPWFuc3dlcnMuc2VhcmNoX2ZubCZwX3BhZ2U9MQ**&p_li=&p_topview=1
(although they think that the issue appears only on SATA which is
definitely not true)
Please have a detailed look on the NCQ of the drives:
This would be (according to how NCQ works) the most likely reason for
the error,... and some people say that deactivating it under Windows,
solved the issue. Anyway,... if NCQ was responsible for the error,.. it
would not appear on the IDE drives (but it does).
And I'm not even sure if Linux/libata (until kernel 2.6.18.x) even uses
NCQ. I always thought it would not but I might be wrong. See this part
of my dmesg:
sata_nv 0000:00:07.0: version 2.0
ACPI: PCI Interrupt Link [LTID] enabled at IRQ 22
GSI 18 sharing vector 0xD9 and IRQ 18
ACPI: PCI Interrupt 0000:00:07.0[A] -> Link [LTID] -> GSI 22 (level,
high) -> IRQ 217
PCI: Setting latency timer of device 0000:00:07.0 to 64
ata1: SATA max UDMA/133 cmd 0x1C40 ctl 0x1C36 bmdma 0x1C10 irq 217
ata2: SATA max UDMA/133 cmd 0x1C38 ctl 0x1C32 bmdma 0x1C18 irq 217
scsi0 : sata_nv
ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata1.00: ATA-7, max UDMA/133, 488397168 sectors: LBA48 NCQ (depth 0/32)
ata1.00: ata1: dev 0 multi count 16
ata1.00: configured for UDMA/133
scsi1 : sata_nv
ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata2.00: ATA-7, max UDMA/133, 488397168 sectors: LBA48 NCQ (depth 0/32)
ata2.00: ata2: dev 0 multi count 16
ata2.00: configured for UDMA/133
  Vendor: ATA       Model: HDT722525DLA380   Rev: V44O
  Type:   Direct-Access                      ANSI SCSI revision: 05
  Vendor: ATA       Model: HDT722525DLA380   Rev: V44O
  Type:   Direct-Access                      ANSI SCSI revision: 05

It says something about NCQ...

-It would also be great if Hitachi could inform me about their current
progress or how long it will take until their engineers start to have a
look at my issue.



Especially for Mr. Dusatko at tyan:

> > Just because memtest86 works it doesn't mean that the memory you are using 
> > is compatible memory. That is why we have a recommended list.
> >
> > Each of the modules on our recommended list have been thoroughly tested. 
> > Most memories pass the memtest86 test, yet many of these do not past our 
> > tests.
> >
> > my tel-nr.
>   
My memory modules are actually on your compatible list (they're the
Kingston KVR400D8R3A/1G) so this cannot be the point.

I still was not able to test your beta BIOS but I'll do so as soon as
possible an report the results. And I'm going to call you this or next
week (have to work at the Leibniz-Supercomputing Centre today and
tomorrow,.. so don't know when I have enough time).


Thanks for now.

Best wishes,
Chris.
#########################################################################
### email #6 to Tyan/Hitachi                                          ###
#########################################################################
Rodger Dusatko - Tyan wrote:

> > you mention:
> >
> >   
>   
>> >> My memory modules are actually on your compatible list (they're the
>> >> Kingston KVR400D8R3A/1G) so this cannot be the point.
>> >>     
>>     
> >
> > I have talked with so many customers about this very problem. Just because 
> > the part-nr. of the Kingston modules is correct, this means absolutely 
> > nothing.
> >
> > You need to also have the same chips as on our recommended website. The 
> > chips being used are even more important than the kingston part-nr.
> >
> > The chips on the KVR400D8R3A/1G must be Micron, having chip part-nr. 
> > MT46V64M8TG-5B D as shown on our recommended memory page.
> >   
>   
I'll check this these days and inform you about the exact chips on the DIMMs

Anyway...
What do you say to the reasons why I don't think that the memhole stuff
is a real solution but more a poor workaround (see my last email,..
which is attached below).
You didn't comment on my ideas in your last answer.


> > This is a grave problem with Kingston memory and why I would only recommend 
> > Kingston memory when your supplier is willing to help you to get the exact 
> > modules which we have tested.
> >   
>   
Well are you absolutely sure that this is memory related? (See also my
comments in my last email)
Note that lots of users were able to solve this via disk drive firmware
upgrades and many of them didn't have Kingston RAMs.
Also,... all RAMs "shoudl" be usable as all "should" follow the SDRAM
standard...

If there would be a Kingston error,.. that data corruption issue should
appear everywhere, shouldn't it? And not only on hard disk accesses.


In all doing respect, and please believe me that I truely respect your
knowledge and so (because you surely know more about hardware because my
computer science study goes more about theoretical stuff)... but I
cannot believe that this is the simple reason,... "wrong RAMs wrong BIOS
settings and you cannot use your full RAM" (see my reasons in my last
email)...
I'd say that there is somewhere a real and perhaps grave error....
either on the board itself ot the nvidia chipset (which I suspect as the
evil here ;-) ).
And I think the error is severe enought that there should be made a
considerable effort to solve it, or at least, exactly locate where there
error is, and why the memhole disabled solves it.

And remember,... it may be the case that the data corruption doesn't
appear when UDMA (at PATA drives) is disabled,.. but this shouldn't have
to do anything with memory vendor or memhole settings,... so why would
this solve the issue, too (if it actually does which I cannot proove)?

I'm also going to start my test with changing the following BIOS settings:
SCSI Bus master from my current setting Enabled to Disabled
Disk Access Mode (don't recall the actual name) from Other to DOS.

I'm going to report you the results next week,.. and I'll probably going
to call you again.



> > Wiith ATP or other vendors, they stick usually to the same chips as long as 
> > the vendor part-nr is the same. In such a case, you probably would have been 
> > right when the vendor part-nr matches your part-nr.
> >
> > The problems you are having, as I mentioned before, may disappear if you use 
> > memory on our recommended memory list.
> >   
>   
Is it possible for Tyan to borrow me such memory for testing? I live in
Munich and Tyan Germany is in Munich too, if I recall correctly.


Thanks in adc

Best wishes,
Chris.
#########################################################################
### email #7 to Tyan/Hitachi                                          ###
#########################################################################
Sorry I forgot one thing:
The beta BIOS you gave me did not change anything.
As soon as I activate memhole mapping (either to software, hardware or
auto),.. data corruption occurs.

Chris.
#########################################################################
### reply to #1 from Tyan                                             ###
#########################################################################
Hello Chris,

there are often problems which are not really so easy to understand.

As I understand it, the hard disk uses DMA (Direct Memory Access), which is 
supported by the chipset.

The processor uses the DMA access to the DIMMs through the chipset to write 
to the disks.

Now, I really am not an expert on this, but normally the DMA is not used by 
the processor when communicating with the memory, but rather the 
hypertransport connection.

This may be an explanation of what is causing the problem. Because a driver 
for HDDs also exists, there may be different links where the problem is 
occuring.

The driver may be able to solve problems which can make it that even using 
the hardware setting for memory hole causes no problems. However, there are 
many different amd cpu steppings, all different in how they manage memory 
(and in this case, the memory hole). If the drivers take all of these 
considerations, they may be able to adjust according to the processor being 
used. But I am not sure if the people who write these drivers get involved 
with this.

Rodger



, the DMA s supported from the chipset   uses the DMA access for 
communicating with the processor, the memory
----- Original Message ----- 
...
...
...




That were all (important) emails so until now.

