Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129464AbRAATxv>; Mon, 1 Jan 2001 14:53:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129485AbRAATxm>; Mon, 1 Jan 2001 14:53:42 -0500
Received: from adsl-63-195-162-81.dsl.snfc21.pacbell.net ([63.195.162.81]:13065
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S129464AbRAATx3>; Mon, 1 Jan 2001 14:53:29 -0500
Date: Mon, 1 Jan 2001 11:22:53 -0800 (PST)
From: Andre Hedrick <t13@linux-ide.org>
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: [temp t13] Set Features CPRM Lock, Proposal (was Re: CPRM) (fwd)
Message-ID: <Pine.LNX.4.10.10101011107010.23211-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Anyone want to comment on the proposal to create a global setfeatures
lockout of CPRM?  The  language used is in terms of the SPEC.

Andre Hedrick
CTO Timpanogas Research Group
EVP Linux Development, TRG
Linux ATA Development

---------- Forwarded message ----------
Date: Sat, 30 Dec 2000 02:24:46 -0800 (PST)
From: Andre Hedrick <t13@linux-ide.org>
Reply-To: t13@tgi.com
To: t13@tgi.com
Subject: [temp t13] Set Features CPRM Lock, Proposal (was Re: CPRM)

  ** This is the quasi-official and semi-temporary T13 email list server. **


Mr. Chairman,

I am request a Proposal Number to present the content below at the
February meeting.  Of course I am aware that I will need to get a 2/3
support in a roll-call vote of approval to allow adoption in to ATA-6;
however, this is only necessary if "e00148rX" is adopted in the same
fashion and rules during the February meeting.

Upon receiving the number I will submit the document to be reviewed by all.

The purpose of this offensive crossover feature set is to prevent a valid
JAVA type CPRM tool from attempting to perfrom a CPRM action without the
HOST first giving notice for enduser certification of the process.

Upon applying this method, T13 may prevent issues that may be deemed
actionable by forcing the customer to choose to allow CPRM actions to be
performed on their HOST.  They must issue the passcode to unlock the
feature block to allow CPRM HOST action to be performed.

Apply this constraint against the "e00148rX" and make it a feature that
can be disabled and locked out if desired, then you will see better
acceptance.  This will provide the MPAA people with a method of stopping
CPRM content from going to a device that does not allow CPRM features to
be enabled.  Everybody wins.

Finally, if CPRM  proposal is removed from possible adoption, I will
withdrawl this proposal due to lack of symbiotic requirements.
Additionally if this can be ammended to "e00148rX", then a new document
will not be needed.

On Fri, 29 Dec 2000, Dale Smith wrote:

>   ** This is the quasi-official and semi-temporary T13 email list server. **
> 
> I agree with your issue's Hugh, and it makes it
> tough on honorable people.
> 
> The entertainment industry will find ways to release
> their songs in a protected format for play on
> personal players. T13 can take the high road, and

Songs are long gone...this is more about protecting the SEWER content of
Hollywood, in my humble opinion.  They what the ablity to charge you on a
per usage basis, regardless that you own and purchased the content at an
earlier time.  Let the Law enforcement divisions go after bootleggers.

Locks only server to keep honest people honest!

> make a stand for freedom and against copy protection 
> on the grounds that individuals should be trusted 
> until they prove themselves untrustworthy, or we can 
> go along with the entertainment industries methods 
> of forcing compliance with copyright rules by removing 
> the temptation. 

Wait until this is not limited to Hollywood content and it effects
Commerice and Trade because of a bad host (or employee/hacker), encrypts
critical data for the operations of Wall Street and beyond.

The only positive note is that CPRM viruses are not spreadable..... ;-)

> This decision is likely to made by executive pocketbooks
> as Hale pointed out earlier.

Hale has always had the vision of what is right and wrong, and that is why
I went full tilt to successfully stop/postpone this from being adopted at
the last meeting in Irvine.  If you look at the orginal unsanitized
version of this proposal the e00148r0 (note totally rejected in October)
verses the stripped down almost technical version of e00148r2, you get the
real picture.

Now if you guys want to get me off the topic, ypou make e00148r3/4 for the
meeting in February at Dell contain this addition.

New Command Pair:

Set Features CPRM Lock. 0x4C and 0xAC
	(Yes I cleverly picked the pair to reflect their true nature)
----------------------------------------------------
These commands SHALL be included in all devices that support/enable the
CPRM "e00148rX", which is now defined as OPTIONAL.  Regardless if the CPRM
key locks are supported, CPRM Enable:Disable SHALL be supported.
----------------------------------------------------
The Enable Feature command SHALL be set only by embedded HOST that do not
have an External HOST to overide the feature.  The Enable Feature command
SHALL set a concatenated 32-bit passcode to hold the enable lock.

INPUTS:				Enable CPRM Mode Lock
	Feature				0x4C
	Sector Count			.c3
	Sector Number			.c2
	Cylinder Low			.c1
	Cylinder High			.c0
	Device Head		obs|na|obs|DEV|na|na|na|na
	Command				0xEF

Sector Count -
Sector Number -
Cylinder Low -
Cylinder High -
	The .c3 .c2 .c1 .c0 SHALL compose a valid lock which will
	comprise and be limited to a 32-bit word size.  The Enable
	concatenated passcode SHALL have two RESERVED Values
	0xFFFFFFFF and 0x00000000.
Device/Head -
	DEV is to indicate device selection.

NORMAL OUTPUTS:
	Error				na
	Sector Count			.d3
	Sector Number			.d2
	Cylinder Low			.d1
	Cylinder High			.d0
	Device Head		obs|na|obs|DEV|na|na|na|na
	Status			BSY|DRDY|DF|na|DRQ|na|na|ERR

Sector Count -
Sector Number -
Cylinder Low -
Cylinder High -
	The .d3 .d2 .d1 .d0 SHALL return the accepted passcode in the same
	format that was issued.
Device/Head -
	DEV is to indicate device selection.
Status register -
	BSY: shall be clear to zero indicating command completion
	DRDY: shall be clear to zero
	DF: (Device Fault) shall be clear to zero
	DRQ: shall be clear to zero
	ERR: shall be clear to zero
	
ERROR OUTPUTS:
	Error			na|UNC|na|IDNF|na|na|ABRT|na
	Sector Count			reserved
	Sector Number			reserved
	Cylinder Low			reserved
	Cylinder High			reserved
	Device Head		obs|na|obs|DEV|na|na|na|na
	Status			BSY|DRDY|DF|na|DRQ|na|na|ERR

Error -
	UNC: shall be set to one if the passcode is not accepted.
	IDNF: shall be set to one if the passcode was never set.
	ABRT: shall be set to one if this command is not supported, if
	the passcode is not accepted, or if the passcode was never set.
Sector Count -
Sector Number -
Cylinder Low -
Cylinder High -
	Reserved:
Device/Head -
	DEV: is to indicate device selection.
Status register -
	BSY: shall be clear to zero indicating command completion
	DRDY: shall be clear to one.
	ERR: shall be clear to one if an Error register bit is set to one.

----------------------------------------------------
The Disable Feature command MAY be set only by any HOST. The Disable
Feature command SHALL set a concatenated 32-bit passcode to hold the STATE
of the lock and SHALL NOT be cleared to enable except by the External HOST.

INPUTS:				Disable CPRM Mode Lock
	Feature				0xAC
	Sector Count			.c3
	Sector Number			.c2
	Cylinder Low			.c1
	Cylinder High			.c0
	Device Head		obs|na|obs|DEV|na|na|na|na
	Command				0xEF

Sector Count -
Sector Number -
Cylinder Low -
Cylinder High -
	The .c3 .c2 .c1 .c0 SHALL compose a valid lock which will
	comprise and be limited to a 32-bit word size.  The Disable
	concatenated passcode SHALL have two RESERVED Values
	0xFFFFFFFF and 0x00000000.
Device/Head -
	DEV: is to indicate device selection

NORMAL OUTPUTS:
	Error				na
	Sector Count			.d3
	Sector Number			.d2
	Cylinder Low			.d1
	Cylinder High			.d0
	Device Head		obs|na|obs|DEV|na|na|na|na
	Status			BSY|DRDY|DF|na|DRQ|na|na|ERR

Sector Count -
Sector Number -
Cylinder Low -
Cylinder High -
	The .d3 .d2 .d1 .d0 SHALL return the accepted passcode in the same
	format that was issued.
Device/Head -
	DEV: is to indicate device selection.
Status register -
	BSY: shall be clear to zero indicating command completion
	DRDY: shall be clear to zero
	DF: (Device Fault) shall be clear to zero
	DRQ: shall be clear to zero
	ERR: shall be clear to zero

ERROR OUTPUTS:
	Error			na|UNC|na|IDNF|na|na|ABRT|na
	Sector Count			reserved
	Sector Number			reserved
	Cylinder Low			reserved
	Cylinder High			reserved
	Device Head		obs|na|obs|DEV|na|na|na|na
	Status			BSY|DRDY|DF|na|DRQ|na|na|ERR

Error -
	UNC: shall be set to one if the passcode is not accepted.
	IDNF: shall be set to one if the passcode was never set.
	ABRT: shall be set to one if this command is not supported, if
	the passcode is not accepted, or if the passcode was never set.
Sector Count -
Sector Number -
Cylinder Low -
Cylinder High -
	Reserved:
Device/Head -
	DEV: is to indicate device selection.
Status register -
	BSY: shall be clear to zero indicating command completion
	DRDY: shall be clear to one.
	ERR: shall be clear to one if an Error register bit is set to one.

----------------------------------------------------
Standard Non-Data will be issued and the same error handling SHALL be
observed; however the follow execption SHALL report with the content in
the sub-set-features registers.

----------------------------------------------------
Additionally the Feature Support and Feature Enable Bits of the CPRM
"e00148rX" proposal reflect in a manner that standard in the reported mode
of IDENTIFY DEVICE.

Once the Set Features CPRM Lock command is set, the bits in Words 83 and
86 SHALL be effected in the following manner, as it relates to the newly
to be created "Copy Protection Feature Set Supported/Enabled".

Word 83 "Set Features CPRM Lock Support" shall be set to one,
if Word 83 for "Copy Protection Feature Set Supported" is set to one.

Word 86 "SetFeatures CPRM Lock Enable" shall be set to one, if the HOST
has issued a "Set Features CPRM Lock Disable Command" succesfully.  The
result of which set the "Set Features CPRM Lock Disable Enable" to one
will also set and lock the "Copy Protection Feature Set Enabled" to zero.

Therefore "Copy Protection Feature Set Supported" shall issue an ABORT to
any HOST request to activate the "Copy Protection Feature Set" until the
"Set Features CPRM Lock Disable" is cleared by the HOST.

-------------------------------------------------

Regards,

Andre Hedrick
CTO Timpanogas Research Group
EVP Linux Development, TRG
Linux ATA Development





--
  If you have any questions or wish to unsubscribe send a 
  message to Hale Landis, hlandis@attglobal.net. To post to
  this list server send your message to t13@tgi.com.
  
  For questions concerning Thistle Grove Industries or TGI's
  list services please send email to info@tgi.com.



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
