Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281890AbRKWEb6>; Thu, 22 Nov 2001 23:31:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281984AbRKWEbt>; Thu, 22 Nov 2001 23:31:49 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:15488 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S281890AbRKWEbd>; Thu, 22 Nov 2001 23:31:33 -0500
Date: Thu, 22 Nov 2001 22:34:43 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: linux-kernel@vger.kernel.org
Cc: jmerkey@timpanogas.org
Subject: [PATCH] NetWare File System/M2FS/NWFS posted 2.4.15-pre9
Message-ID: <20011122223443.A719@vger.timpanogas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



A kernel patch has been posted at 

ftp.timpanogas.org:/nwfs/nwfs-2.4.15-pre9-1.bz2 and
ftp.utah-nac.org:/nwfs/nwfs-2.4.15-pre9-1.bz2 

This patch integrates the NetWare File System (NWFS) and the 
enablement hooks for the Clustered NetWare File System (M2FS) 
into the Native Linux Kernel.  The cluster server and user space
components are not included in this patch and will be posted 
at a later date, hopefully around the Salt Lake City Olympics.  The 
interface currently supported for the M2FS clustered file system 
is Dolphin's Scalable Coherent Interface (SCI).  We have measured 
cache-to-cache transfers over SCI with the 66Mhz adapters at 210 MB/S 
between file system nodes.  We have support for Ethernet, etc. but
it is not as robust or high-performance as SCI.  SCI allows direct 
memory-to-memory mapping of cache pages between nodes.  The M2FS
design is **NOT** NUMA or ccNUMA, we are simply using the NUMA/ccNUMA
capability of the Dolphin technology to provide push/pull 
capability via messages between node caches.  

We have no plans to support Myrinet or other NUMA adapters at this 
time.  We leave this work to others who may be interested in 
integrating their support into M2FS.   M2FS has been a very long 
time in coming.  Please be patient.  We are testing at present,
and are very close to having a hardened code base for posting.

LEGAL ANALYSIS of NWFS INCLUSION INTO LINUX
-------------------------------------------

A legal brief will be sent Friday afternoon on this topic to the addressees
who are the decision makers of Linux which includes copies of relevant 
agreements between TRG and Novell regarding Intellectual property.  We 
apologize for our tardiness, however, our attorneys have been working 
dilegently on several other cases, and are working as fast as they can 
to pull the necessary documentation together.  The Novell/TRG lawsuit 
comprises over 900,000 pages of materials, so for obvious reasons, it 
takes a while to go through all this stuff. 

The summary of our analysis is not, however, privileged, and can be divulged 
in this forum so all Linux members can discuss and review the information.  
We respectfully ask for folks to stop pinging Andre Hedrick on these 
issues.  Andre has been very helpful, however, he has been acting as a 
coordinator, but he is not an "insider" on what is going on with TRG, and
has directed that we forward materials to a specfic list of decision 
makers.  We appreciate Andre's assistance to date on this topic.  Andre
has contacted us with many of these requests, and most of them should 
probably be coming directly to me from this point forward.  It is 
very generous and kind of Andre to attempt to field some of these requests,
however, they are probably taking a lot of his time, and we have no 
desire to impinge on his very busy schedule.  Andre is very much a person
who has a strong drive to "belong" and be helpful to others, very 
admirable and honorable traits.


ANALYSIS
--------

Novell filed a cause of action against TRG and Jeff Merkey, Darren Major,
and Larry Angus in April of 1997.  This litigation was settled in 
July of 1998.  A settlement agreement was executed which included the 
imposition of a permanent injunction that prohibits TRG, and the people 
named above from "possessing, using, or distributing NetWare or Wolf
Mountain Source code defendants had access to while employed at Novell."
Obviously, we should not be doing anything with code that belongs to 
Novell, so we agreed to this injunction.  We do not, nor ever had such
code after we left Novell.  The presiding Judge stated in his 
ruling of February 1998 that "No Novell source code had been 
used in any TRG projects, nor was there the appearance that any 
had been used orthat TRG had access to such code."

This settlement agreement also states, "Defendants are released from 
their obligations to maintain Novell information in confidence, and are 
free to reenter any prohibited areas after experation of the preliminary 
non-compete injunction (18 months)."  This language effectively released 
us from our prior trade secret agreements.  It mirrored the ruling of 
the court.  This ruling was posted in February of 1998 in case 
9704-339.  In this ruling, the court ruled that Novell was only allowed 
to claim an 18 month window of exclusitivity of their "trade secrets."  
Following the settlement agreement, Novell could not even claim this, 
since they waived their rights to claim trade secrets under the terms 
of this agreement.  

At the time this agreement was signed, I had filed suit against 
Novell for sexual harassment relative to my departure from Novell.
The suit claimed I had been sexually harrassed by Dr. Eric Schmidt
(Ugh!!!) and another executive at Novell.  Part of the reason I left
Novell was due to these incidents.  I am not going into 
the details of these incidents, suffice to say they were "vile"
from my viewpoint.  In exchange for dropping this lawsuit and 
agreeing never to disclose publically the specific "blow by blow"
actions of the executives involed, Novell agreed to release us from 
our trade secret agreements.  This factual information is documented 
in these agreements.  

The settlement agreement contains a listing of actions Novell was required
to take in the event they believed we were "using source code we obtained
while employed at Novell."  This agreement called for audits to be
conducted over a period of three years.  Novell conducted one of these
audits in August of 1998 pursuant to the agreement.  They failed 
thereafter to perform any additional audits as required by this 
agreement, and in doing so, waived their rights to object to any 
released code.  NWFS on Linux was announced in the Winter of 1998 and 
posted in early 1999.  Novell general counsel David Bradford sent
several emails in 1999 to me complaining about the release of NWFS 
on Linux.  I informed him to perform an audit and prove we were 
using NetWare code if he believed this, and bring an OFC (Order 
for Cause).  On order for cause is a criminal contempt order 
brought to enforce a settlement agreement, judgement, or 
order of a court.  There are prescribed time limits of 
24 months (2 years) under Utah Law.  

Novell did not take any of these actions.  NWFS was a total rewrite
from the ground up, and Novell after analyzing the code posted 
publically, discovered this was in fact so.  TRG has a complete
archive of NWFS development maintained by our in-house law firm.
Novell also was aware that TRG moved several attorneys in with 
us and created an "in-house" law firm prior to the release of NWFS 
for the very purpose of documenting our code development in the 
event Novell attempted more of their dishonest posturing with 
the Court.   In Utah, a sitting Judge is required to take an 
attorneys word at face value.  They have in-house lawyers, 
and so do we.

In order for Novell to comply with this agreement, they had to 
raise an objection within the 18 months defined by the Court's
ruling, and possibly within the 24 month rule as well.  They did not 
do this with regard to NWFS, and as such have waived their rights 
to bring any cause of action against TRG regarding this code.  Novell 
could bring an action, but only against TRG.  Novell has no power 
to bring an action against transmeta, red hat, suse, etc. for any 
code taken from TRG and incorporated.  Novell can only bring such an
action against TRG since we are the subject of these orders.  

Now the question as to why Novell is continuing to make statements
to partners needs to be examined.  This agreement also contains 
a provision that prohibits Novell's employees from making 
**ANY** public statements or statements to partners about TRG 
or any issues about TRG's business or any matters related to 
the TRG/Novell lawsuit.  Within 30 days of the settlement agreement
being signed, Novell's employees promptly were out bashing us in
public and making statements we were thieves, and had stolen source
code.  To date we have documented over 300 such incidents, and have 
sent a mountain of correspondence to Novell cataloging these events.
The agreement allows TRG to collect $100,000 in cash for each and 
every one of these violations.  When NWFS was posted, Novell knew 
we had documented dozens of such breaches by their employees, and
feared sanctions and punitive damages if they attempted a direct 
route of attack.  They have since done everything they can to
"ignore" us or present the appearance they are "ignoring us" to 
others.  Their current mode of attack to to threaten vendors with 
letters and emails, stating, "if you do business with them, and they
have any of our code, we will harrass you and you will be subject 
to an OFC with them."  These are for the most part empty threats. 
Novell can only sue us, not others, and suing "Linux" is a rather
large target.  They are going out of business at present, and have much 
bigger fish to fry at the present time.

Unfortunately, most large companies simply want to avoid such 
entaglements, and it is simply easier and simpler to avoid doing
business with TRG, and this has been the affect.  Novell has succeeded
in chasing away all of TRGs investors, partners, and customers 
with this approach, since large companies do no like having 
lawyers serving them with email production requests and other 
forms of "harrassment."  What is diffcult to communicate to these
folks is that Novell has no basis for these statements, and are 
terrified of the prospect of litigation with us.  I managed to 
cost them $17,000,000.00 dollars in attorneys fees, and I succeeded
in getting David Bradford, Denice Gibson, Eric Schmidt, Joe Marengi,
Vic Langford, and a long list of other executives fired from the 
company over time due to the problems this conflict has and is continuing
to cause Novell.  I did not ask for this lawsuit, but they should know 
better than to declare war on an American Indian.  We are always 
ready and willing to smoke the peace pipe.  Novell has shown no 
inclination to do so.  :-)

We will provide JPEG version of these materials to the folks who 
need to review them.  Based on our analysis, Novell is on shaky 
ground if they attempt to bring a cause of action with regard to
NWFS inclusion into Linux.  This is not the case with MANOS, NDS,
or other projects.  Novell has patents, and we believe they will
attack if an open source NDS is posted or replacement OS.  Such a 
release would kill them overnight.  NWFS actually helps them, since
it promotes their file system technology on other platforms.  As such
these other projects (NDS,MANOS) have been shelved, and I plan to 
leave them shelved.

We do hereby indemnify all persons listed in the CREDITS file 
in Linux against any and all claims by Novell.  This statement 
means that if Novell tries to sue anyone, we become liable for 
all costs and Novell's case gets dismissed as a matter of law.  We
also do hereby indemnify all Linux companies, partners, customers,
contributors, etc or any other person who uses NWFS on Linux.  We 
are also filing for dissolution of the permaanent injunction 
Monday, November 26 2001, since it has run it's term, and Novell's
four year window for keeping it has expired.  Novell at this point 
has to show we A) have copies of thier code and B) we are using
it, and C) curcumstances are the same as five years ago in order
to retain this injunction.  As it stands, any action they bring 
can be dismissed as a matter of law on the grounds they A) have 
breached the agreement B)  they have failed to perform audits 
as required by the agreement C) the 18 month windows on trade 
secret claims has expired D) the 24 month limit on bring an OFC 
for violation of the injunction has expired E) NWFS contains no
source code we had access to while employed at Novell and was 
developed independent of Novell.

We recommend inclusion of NWFS beginning with Linux 2.5 when 
the page cache issues can be resolved.  We are also dissolving
the permanent injunction, which will close Novell's ability to 
bring any OFC against TRG relative to the 1997 litigation.  We have
also indemnified Linux and it's members under 27 CFR which effectively
shields the Linux community and its customers from any claims brought 
by Novell (they revert to us).  

We see no genuine issue of fact or matter of law that prevents 
adoption by anyone of NWFS on Linux for the reasons stated.


Respectfully Submitted,

Jeff Merkey
TRG/Utah NAC












