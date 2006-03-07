Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932604AbWCGBug@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932604AbWCGBug (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 20:50:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932605AbWCGBuf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 20:50:35 -0500
Received: from pproxy.gmail.com ([64.233.166.179]:61173 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932604AbWCGBuc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 20:50:32 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=IrOP7UVpb95mcWtpYILeujdkkns4EtNhTCCkt7wdAR1AkvYEKmATP9yXf3rlIhZ6Pm58UhVLNHftVA48tSnojxVGtN2vE8aYieP/nFCE1zFRKWM1/cBp8zWLInmltOMOO1OQX2fznxlP4XD/JZjk/KqcMrQ5umEW0XvueagBtzk=
Message-ID: <756b48450603061750i574b88efja011648323541d45@mail.gmail.com>
Date: Tue, 7 Mar 2006 09:50:28 +0800
From: "Jaya Kumar" <jayakumar.acpi@gmail.com>
To: "Yu, Luming" <luming.yu@intel.com>
Subject: Re: [PATCH 2.6.15.3 1/1] ACPI: Atlas ACPI driver
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <3ACA40606221794F80A5670F0AF15F84041AC25E@pdsmsx403>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_1267_4102543.1141696228649"
References: <3ACA40606221794F80A5670F0AF15F84041AC25E@pdsmsx403>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_1267_4102543.1141696228649
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On 3/6/06, Yu, Luming <luming.yu@intel.com> wrote:
> >- acpi_video_bus_check fails out if no _DOS,_ROM,_GPD,_SPD,_VPO. this
> >check fails on Atlas because it doesn't have any of those
>
> These check might be too strict. To face reality, it might need
> be more loose, because it depends on platform vendor to implement
> acpi video extension.

Ok. I think I understand.

> >acpi_video_output_device_exceptions_detect() )... or do you want me to
> >do something cleaner and move the whole _BCM detection earlier in the
> >process?
>
> moving it earlier might better.

I'll try to do that.

> >- acpi_video_bus_get_devices will only call video_bus_get_one_device
> >if the device node has children. In Atlas, the "Video Bus", (ie: LCD
> >device in the DSDT I pasted before) has no children, at least as found
> >by scan.c, so we won't get to get_one_device(). What do you think I
> >should do about this?
>
> Please resend me the acpidump, it's somehow dropped from my mailbox.

I've added it as an attachment here. Please let me know if you get it.

>
> >
> >I have a suspicion that for boards like this where ACPI support isn't
> >so complete, we should just use board specific drivers rather than
> >mangling the mainstream video driver code. What do you think?
>
> that is the last resort, if you can prove video.c or hotkey.c is NOT
> capable to handle . We do need to make things as generic as possible
> in this area, otherwise, I cannot imagine how they can be maintained .
> That's the reason why I'm thinking about to propose a ACPI hotkey spec.
> Do you have idea for that?

Yes, you are right about making things generic. I'll try harder to
integrate it with video.c. For the latter, I'm not sure if hotkey is
correct for Atlas. Perhaps you mean the button support? Because
physically, these are buttons rather than hotkeys.

Thanks,
jayakumar

------=_Part_1267_4102543.1141696228649
Content-Type: text/plain; name=dsdt.dsl; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Attachment-Id: f_ekhkntrl
Content-Disposition: attachment; filename="dsdt.dsl"

/*
 * Intel ACPI Component Architecture
 * AML Disassembler version 20050902
 *
 * Disassembly of /tmp/dsdt.dat, Thu Feb 16 16:25:13 2006
 */
DefinitionBlock ("DSDT.aml", "DSDT", 1, "INSYDE", "CS5535  ", 4103)
{
    Name (_T01, Zero)
    Name (_T00, Zero)
    Name (VERS, Package (0x04)
    {
        "Project: AMD Emma Platform", 
        "May 20 2005", 
        "11:44:11", 
        "Vers: 0.01.10"
    })
    OperationRegion (X80, SystemIO, 0x80, One)
    Field (X80, ByteAcc, NoLock, Preserve)
    {
        P80,    8
    }

    OperationRegion (DEC1, SystemIO, 0x02F8, 0x08)
    Field (DEC1, ByteAcc, NoLock, Preserve)
    {
        DEC3,   8, 
        DEC4,   8, 
        Offset (0x03), 
        DEC5,   8, 
        DEC6,   8, 
        DEC7,   8
    }

    Method (DECA, 0, NotSerialized)
    {
        Store (0x83, DEC5)
        Store (0x02, DEC3)
        Store (Zero, DEC4)
        Store (0x03, DEC5)
        Store (0x03, DEC6)
        Store (Zero, DEC4)
    }

    Method (THRE, 0, NotSerialized)
    {
        And (DEC7, 0x20, Local0)
        While (LEqual (Local0, Zero))
        {
            And (DEC7, 0x20, Local0)
        }
    }

    Method (OUTX, 1, NotSerialized)
    {
        THRE ()
        Store (Arg0, DEC3)
    }

    Method (OUTC, 1, NotSerialized)
    {
        If (LEqual (Arg0, 0x0A))
        {
            OUTX (0x0D)
        }

        OUTX (Arg0)
    }

    Method (DBGN, 1, NotSerialized)
    {
        And (Arg0, 0x0F, Local0)
        If (LLess (Local0, 0x0A))
        {
            Add (Local0, 0x30, Local0)
        }
        Else
        {
            Add (Local0, 0x37, Local0)
        }

        OUTC (Local0)
    }

    Method (DBGB, 1, NotSerialized)
    {
        ShiftRight (Arg0, 0x04, Local0)
        DBGN (Local0)
        DBGN (Arg0)
    }

    Method (DBGW, 1, NotSerialized)
    {
        ShiftRight (Arg0, 0x08, Local0)
        DBGB (Local0)
        DBGB (Arg0)
    }

    Method (DBGD, 1, NotSerialized)
    {
        ShiftRight (Arg0, 0x10, Local0)
        DBGW (Local0)
        DBGW (Arg0)
    }

    Method (DBGO, 1, NotSerialized)
    {
        DECA ()
        If (LEqual (ObjectType (Arg0), One))
        {
            If (LGreater (Arg0, 0xFFFF))
            {
                DBGD (Arg0)
            }
            Else
            {
                If (LGreater (Arg0, 0xFF))
                {
                    DBGW (Arg0)
                }
                Else
                {
                    DBGB (Arg0)
                }
            }
        }
        Else
        {
            Name (BDBG, Buffer (0x50) {})
            Store (Arg0, BDBG)
            Store (Zero, Local1)
            While (One)
            {
                Store (GETC (BDBG, Local1), Local0)
                If (LEqual (Local0, Zero))
                {
                    Return (Zero)
                }

                OUTC (Local0)
                Increment (Local1)
            }
        }

        Return (Zero)
    }

    Method (GETC, 2, NotSerialized)
    {
        CreateByteField (Arg0, Arg1, DBGC)
        Return (DBGC)
    }

    OperationRegion (ODRN, SystemIO, 0x0378, One)
    Field (ODRN, ByteAcc, NoLock, Preserve)
    {
        OEMD,   8
    }

    OperationRegion (VSA1, SystemIO, 0xAC1C, 0x04)
    Field (VSA1, WordAcc, NoLock, Preserve)
    {
        VSA2,   16, 
        VSA3,   16
    }

    Mutex (VSA4, 0x00)
    Method (VSA5, 0, NotSerialized)
    {
        Acquire (VSA4, 0xFFFF)
    }

    Method (VSA6, 0, NotSerialized)
    {
        Release (VSA4)
    }

    OperationRegion (VSAB, SystemIO, 0x9C24, 0x04)
    Field (VSAB, DWordAcc, NoLock, Preserve)
    {
        VSAC,   32
    }

    Mutex (VSAD, 0x00)
    Method (VSAE, 0, Serialized)
    {
        Acquire (VSAD, 0xFFFF)
    }

    Method (VSAF, 0, Serialized)
    {
        Release (VSAD)
    }

    Method (VSAG, 1, Serialized)
    {
        Name (RDMB, Buffer (0x08) {})
        CreateDWordField (RDMB, Zero, RDM0)
        CreateDWordField (RDMB, 0x04, RDM1)
        VSAE ()
        Store (0x41534C55, VSAC)
        Store (Arg0, VSAC)
        Store (VSAC, Local0)
        Store (VSAC, Local1)
        VSAF ()
        Store (Local0, RDM0)
        Store (Local1, RDM1)
        Return (RDMB)
    }

    Method (VSAH, 2, Serialized)
    {
        CreateDWordField (Arg1, Zero, RDM0)
        CreateDWordField (Arg1, 0x04, RDM1)
        VSAE ()
        Store (0x41534C55, VSAC)
        Store (Arg0, VSAC)
        Store (RDM0, VSAC)
        Store (RDM1, VSAC)
        VSAF ()
    }

    Method (VSA7, 1, Serialized)
    {
        Name (VRRR, Zero)
        VSA5 ()
        Store (0xFC53, VSA2)
        Store (Arg0, VSA2)
        Store (VSA3, Local0)
        VSA6 ()
        Store (Local0, VRRR)
        Return (VRRR)
    }

    Method (VSA8, 2, Serialized)
    {
        ShiftLeft (Arg0, 0x08, Local0)
        Add (Local0, Arg1, Local0)
        Name (VRRR, Zero)
        VSA5 ()
        Store (0xFC53, VSA2)
        Store (Local0, VSA2)
        Store (VSA3, Local1)
        VSA6 ()
        Store (Local1, VRRR)
        Return (VRRR)
    }

    Method (VSA9, 2, Serialized)
    {
        VSA5 ()
        Store (0xFC53, VSA2)
        Store (Arg0, VSA2)
        Store (Arg1, VSA3)
        VSA6 ()
    }

    Method (VSAA, 3, Serialized)
    {
        ShiftLeft (Arg0, 0x08, Local0)
        Add (Local0, Arg1, Local0)
        VSA5 ()
        Store (0xFC53, VSA2)
        Store (Local0, VSA2)
        Store (Arg2, VSA3)
        VSA6 ()
    }

    Method (VR, 2, Serialized)
    {
        ShiftLeft (Arg0, 0x08, Local0)
        Add (Local0, Arg1, Local0)
        DBGO ("VR(")
        DBGO (Arg0)
        DBGO (",")
        DBGO (Arg1)
        DBGO (")=")
        DBGO (Local0)
        DBGO ("\n")
        Return (Local0)
    }

    Name (DAT0, Zero)
    Name (DAT1, Zero)
    Name (DAT2, Zero)
    Name (DAT3, Zero)
    Name (DATA, Package (0x04)
    {
        Ones, 
        Ones, 
        Ones, 
        Ones
    })
    Name (ERFG, Zero)
    Name (ERCD, Zero)
    OperationRegion (SMB0, SystemIO, 0x6000, 0x08)
    Field (SMB0, ByteAcc, NoLock, Preserve)
    {
        SM00,   8, 
        SM01,   8, 
        SM02,   8, 
        SM03,   8, 
        SM04,   8, 
        SM05,   8, 
        SM06,   8, 
        SM07,   8
    }

    Mutex (SMBP, 0x00)
    Method (SMAQ, 0, Serialized)
    {
        Acquire (SMBP, 0xFFFF)
    }

    Method (SMRL, 0, Serialized)
    {
        Release (SMBP)
    }

    Method (CSTP, 0, NotSerialized)
    {
        Store (0x03E8, Local0)
        While (Local0)
        {
            And (SM03, 0x02, Local1)
            If (LEqual (Local1, Zero))
            {
                Return (Local1)
            }

            Decrement (Local0)
            If (LEqual (Local0, Zero))
            {
                Return (One)
            }
        }
    }

    Method (SMBR, 0, NotSerialized)
    {
        Store (Zero, Local1)
        While (LNot (LEqual (Local1, 0x10)))
        {
            Store (Zero, SM05)
            Or (SM05, 0xFE, Local0)
            Store (Local0, SM05)
            Or (Local0, One, SM05)
            And (SM02, 0x10, Local1)
            Store (One, OEMD)
        }
    }

    Method (CBER, 0, NotSerialized)
    {
        Store (Zero, Local0)
        While (LNot (LEqual (Local0, 0x40)))
        {
            And (SM01, 0x20, Local0)
            If (LEqual (Local0, 0x20))
            {
                Store (One, ERFG)
                Return (ERFG)
            }

            And (SM01, 0x40, Local0)
        }

        Return (Zero)
    }

    Method (SMSA, 1, Serialized)
    {
        And (Arg0, 0xFE, SM00)
        Store (Zero, Local0)
        While (LNot (LEqual (Local0, 0x40)))
        {
            And (SM01, 0x10, Local0)
            If (LEqual (Local0, 0x10))
            {
                Store (One, ERFG)
                Return (ERFG)
            }

            And (SM01, 0x40, Local0)
        }

        Return (Zero)
    }

    Method (MTST, 1, Serialized)
    {
        Or (SM03, 0x10, SM03)
        Store (Arg0, SM00)
        Store (Zero, Local0)
        While (LNot (LEqual (Local0, 0x40)))
        {
            And (SM01, 0x10, Local0)
            If (LEqual (Local0, 0x10))
            {
                Store (One, ERFG)
                Return (ERFG)
            }

            And (SM01, 0x40, Local0)
        }

        Return (Zero)
    }

    Method (REDB, 2, Serialized)
    {
        Or (SM03, One, SM03)
        And (SM01, 0x20, Local0)
        If (LEqual (Local0, 0x20))
        {
            Store (One, ERFG)
            Return (ERFG)
        }

        Or (Arg0, One, SM00)
        Store (Zero, Local1)
        While (LNot (LEqual (Local1, Arg1)))
        {
            Store (Zero, Local0)
            While (LNot (LEqual (Local0, 0x40)))
            {
                And (SM01, 0x10, Local0)
                If (LEqual (Local0, 0x10))
                {
                    Store (One, ERFG)
                    Return (ERFG)
                }

                And (SM01, 0x40, Local0)
            }

            If (LEqual (Local1, Arg1))
            {
                Store (0x02, SM03)
            }

            If (LEqual (Local1, Zero))
            {
                Store (SM00, Index (DATA, Zero))
            }

            If (LEqual (Local1, One))
            {
                Store (SM00, Index (DATA, One))
            }

            If (LEqual (Local1, 0x02))
            {
                Store (SM00, Index (DATA, 0x02))
            }

            If (LEqual (Local1, 0x03))
            {
                Store (SM00, Index (DATA, 0x03))
            }

            Increment (Local1)
        }

        Return (Zero)
    }

    Method (WRTB, 3, Serialized)
    {
        Store (Arg2, DAT0)
        Store (DAT0, SM00)
        Store (Zero, Local0)
        While (LNot (LEqual (Local0, 0x40)))
        {
            And (SM01, 0x10, Local0)
            If (LEqual (Local0, 0x10))
            {
                Store (One, ERFG)
                Return (ERFG)
            }

            And (SM01, 0x40, Local0)
        }

        Store (0x02, SM03)
        Return (Zero)
    }

    Method (CMER, 0, NotSerialized)
    {
        Store (0x02, SM03)
        Store (SM01, Local0)
        Store (Local0, SM01)
        Store (0x02, ERCD)
        Store (ERCD, OEMD)
        Return (ERCD)
    }

    Method (CDER, 0, NotSerialized)
    {
        Store (0x04, ERCD)
        Store (ERCD, OEMD)
        Return (ERCD)
    }

    Method (SMBA, 4, Serialized)
    {
        SMAQ ()
        Store (0x05, Local0)
        Store (Zero, ERFG)
        Store (Zero, ERCD)
        While (LNot (LEqual (SMBB (Arg0, Arg1, Arg2, Arg3), Zero)))
        {
            Decrement (Local0)
            If (LEqual (Local0, Zero))
            {
                SMRL ()
                Return (0xFE)
            }
        }

        SMRL ()
        Store (Zero, ERFG)
        Store (Zero, ERCD)
        Return (DATA)
    }

    Method (SMBB, 4, Serialized)
    {
        If (CSTP ())
        {
            SMBR ()
            Store (SM04, Local0)
            Or (0xEF, 0x80, Local1)
            Or (Local0, Local1, Local0)
            Store (Local0, SM04)
        }

        Or (SM03, One, SM03)
        If (CBER ())
        {
            Return (CMER ())
        }

        If (SMSA (Arg0))
        {
            Return (CMER ())
        }

        If (MTST (Arg1))
        {
            Return (CMER ())
        }

        And (Arg2, 0xF0, Local0)
        If (LEqual (Local0, 0x10))
        {
            And (Arg2, 0x0F, Local0)
            REDB (Arg0, Local0)
            If (ERFG)
            {
                Return (CMER ())
            }
        }
        Else
        {
            WRTB (Arg0, Arg1, Arg3)
            If (ERFG)
            {
                Return (CMER ())
            }
        }

        Return (Zero)
    }

    Name (CUNT, Zero)
    Mutex (BTNP, 0x00)
    Method (BTNQ, 0, Serialized)
    {
        Acquire (BTNP, 0xFFFF)
    }

    Method (BTNL, 0, Serialized)
    {
        Release (BTNP)
    }

    Name (BRSV, Zero)
    Method (RBRL, 0, NotSerialized)
    {
        Store (0x32, Local0)
        Return (Local0)
    }

    Method (SBRL, 2, NotSerialized)
    {
        If (LEqual (Arg0, 0x02))
        {
            And (Arg1, Zero, Arg1)
        }
        Else
        {
            If (LEqual (Arg0, One))
            {
                Store (BRSV, OEMD)
                And (\_SB.GLOV, 0xFFFFFFBF, Local0)
                Or (Local0, 0x00400000, \_SB.GLOV)
                Sleep (0x32)
                And (\_SB.GLOV, 0xFFBFFFFF, Local0)
                Or (Local0, 0x40, \_SB.GLOV)
            }
            Else
            {
                If (LEqual (Arg0, Zero))
                {
                    Store (BRSV, OEMD)
                    And (\_SB.GLOV, 0xFFFFDFFF, Local0)
                    Or (Local0, 0x20000000, \_SB.GLOV)
                    Sleep (0x32)
                    And (\_SB.GLOV, 0xDFFFFFFF, Local0)
                    Or (Local0, 0x2000, \_SB.GLOV)
                }
            }
        }
    }

    Scope (_PR)
    {
        Processor (CPU0, 0x01, 0x00000000, 0x00) {}
    }

    Name (INP0, Zero)
    Name (INP1, Zero)
    Name (OUT0, Zero)
    Name (OUT1, Zero)
    Name (POL0, Zero)
    Name (POL1, Zero)
    Name (CFG0, Zero)
    Name (CFG1, Zero)
    Mutex (BATF, 0x00)
    Method (BATQ, 0, Serialized)
    {
        Acquire (BATF, 0xFFFF)
    }

    Method (BATR, 0, Serialized)
    {
        Release (BATF)
    }

    Method (BATI, 1, Serialized)
    {
        VSAA (0x16, 0x10, Arg0)
        Store (VSA8 (0x16, 0x10), Local0)
        Return (Local0)
    }

    Scope (_SB)
    {
        Device (ASIM)
        {
            Name (_HID, "ASIM0000")
            Name (_GPE, Zero)
            Name (_UID, Zero)
            OperationRegion (ASI2, 0x81, Zero, 0x00010000)
            Field (ASI2, AnyAcc, Lock, Preserve)
            {
                BNE1,   8, 
                BNE2,   8, 
                BNE3,   8, 
                BNE4,   8, 
                BNEU,   8, 
                BNED,   8, 
                BNEL,   8, 
                BNER,   8, 
                BNEE,   8, 
                BNES,   8, 
                BNEC,   8, 
                BYES,   8, 
                BYED,   8, 
                BNRD,   8, 
                BNRE,   8, 
                BRLV,   8, 
                BNS1,   8, 
                BNS2,   8, 
                BNS3,   8, 
                BNS4,   8, 
                BNSU,   8, 
                BNSD,   8, 
                BNSL,   8, 
                BNSR,   8, 
                BNSE,   8, 
                BNSS,   8, 
                BNSC,   8, 
                BYSS,   8, 
                BYSD,   8, 
                BSRD,   8, 
                BSRE,   8, 
                BRMX,   8, 
                BNT1,   8, 
                BNT2,   8, 
                BNT3,   8, 
                BNT4,   8, 
                BNTU,   8, 
                BNTD,   8, 
                BNTL,   8, 
                BNTR,   8, 
                BNTE,   8, 
                BNTS,   8, 
                BNTC,   8, 
                BYTS,   8, 
                BYTD,   8, 
                BTRD,   8, 
                BTRE,   8, 
                HDID,   8
            }

            Method (_STA, 0, NotSerialized)
            {
                Return (0x0F)
            }
        }
    }

    Method (BNSV, 2, Serialized)
    {
        BTNQ ()
        If (LNot (LEqual (Arg0, INP0)))
        {
            XOr (Arg0, INP0, Local1)
            Store (Arg0, INP0)
            If (And (Local1, One))
            {
                And (INP0, One, Local0)
                If (LEqual (Local0, One))
                {
                    Store (0x02, \_SB.ASIM.BNES)
                    Store (0x02, \_SB.ASIM.BNSS)
                }
                Else
                {
                    Store (One, \_SB.ASIM.BNES)
                    Store (One, \_SB.ASIM.BNSS)
                }
            }

            If (And (Local1, 0x04)) {}
            If (And (Local1, 0x08))
            {
                And (INP0, 0x08, Local0)
                If (LEqual (Local0, 0x08))
                {
                    Notify (\_SB.AC, 0x80)
                }
                Else
                {
                    Notify (\_SB.AC, 0x80)
                }
            }

            If (And (Local1, 0x10))
            {
                And (INP0, 0x10, Local0)
                If (LEqual (Local0, 0x10))
                {
                    Store (0x02, \_SB.ASIM.BNED)
                    Store (0x02, \_SB.ASIM.BNSD)
                }
                Else
                {
                    And (Arg1, 0x10, Local2)
                    If (LEqual (Local2, 0x10))
                    {
                        Store (One, \_SB.ASIM.BNED)
                        Store (One, \_SB.ASIM.BNSD)
                    }
                    Else
                    {
                        If (LGreater (BRSV, Zero))
                        {
                            SBRL (Zero, One)
                            Decrement (BRSV)
                            Store (0x02, \_SB.ASIM.HDID)
                            Store (RBRL (), \_SB.ASIM.BRMX)
                            Store (BRSV, \_SB.ASIM.BRLV)
                        }
                        Else
                        {
                            Store (VSA8 (0x16, 0x34), Local0)
                            If (LEqual (Local0, One))
                            {
                                VSAA (0x16, 0x34, Zero)
                                VSAA (0x16, 0x35, Zero)
                            }
                        }
                    }
                }
            }

            If (And (Local1, 0x20))
            {
                And (INP0, 0x20, Local0)
                If (LEqual (Local0, 0x20))
                {
                    Store (0x02, \_SB.ASIM.BNER)
                    Store (0x02, \_SB.ASIM.BNSR)
                }
                Else
                {
                    And (Arg1, 0x10, Local2)
                    If (LEqual (Local2, 0x10))
                    {
                        Store (One, \_SB.ASIM.BNER)
                        Store (One, \_SB.ASIM.BNSR)
                    }
                    Else
                    {
                        Store (VSA8 (0x16, 0x34), Local0)
                        If (LEqual (Local0, Zero))
                        {
                            VSAA (0x16, 0x34, One)
                            VSAA (0x16, 0x35, One)
                        }

                        While (LLess (BRSV, 0x20))
                        {
                            SBRL (One, One)
                            Increment (BRSV)
                            Store (0x02, \_SB.ASIM.HDID)
                            Store (RBRL (), \_SB.ASIM.BRMX)
                            Store (BRSV, \_SB.ASIM.BRLV)
                        }
                    }
                }
            }

            If (And (Local1, 0x40))
            {
                And (INP0, 0x40, Local0)
                If (LEqual (Local0, 0x40))
                {
                    Store (0x02, \_SB.ASIM.BNEL)
                    Store (0x02, \_SB.ASIM.BNSL)
                }
                Else
                {
                    And (Arg1, 0x10, Local2)
                    If (LEqual (Local2, 0x10))
                    {
                        Store (One, \_SB.ASIM.BNEL)
                        Store (One, \_SB.ASIM.BNSL)
                    }
                    Else
                    {
                        Store (VSA8 (0x16, 0x34), Local0)
                        If (LEqual (Local0, One))
                        {
                            VSAA (0x16, 0x34, Zero)
                            VSAA (0x16, 0x35, Zero)
                        }

                        While (LGreater (BRSV, Zero))
                        {
                            SBRL (Zero, One)
                            Decrement (BRSV)
                            Store (0x02, \_SB.ASIM.HDID)
                            Store (RBRL (), \_SB.ASIM.BRMX)
                            Store (BRSV, \_SB.ASIM.BRLV)
                        }
                    }
                }
            }

            If (And (Local1, 0x80))
            {
                And (INP0, 0x80, Local0)
                If (LEqual (Local0, 0x80))
                {
                    Store (0x02, \_SB.ASIM.BNEU)
                    Store (0x02, \_SB.ASIM.BNSU)
                }
                Else
                {
                    And (Arg1, 0x10, Local2)
                    If (LEqual (Local2, 0x10))
                    {
                        Store (One, \_SB.ASIM.BNEU)
                        Store (One, \_SB.ASIM.BNSU)
                    }
                    Else
                    {
                        Store (VSA8 (0x16, 0x34), Local0)
                        If (LAnd (LEqual (Local0, Zero), LEqual (BRSV, Zero)))
                        {
                            VSAA (0x16, 0x34, One)
                            VSAA (0x16, 0x35, One)
                        }
                        Else
                        {
                            If (LLess (BRSV, 0x20))
                            {
                                SBRL (One, One)
                                Increment (BRSV)
                                Store (0x02, \_SB.ASIM.HDID)
                                Store (RBRL (), \_SB.ASIM.BRMX)
                                Store (BRSV, \_SB.ASIM.BRLV)
                            }
                        }
                    }
                }
            }
        }

        If (LNot (LEqual (Arg1, INP1)))
        {
            XOr (Arg1, INP1, Local1)
            Store (Arg1, INP1)
            If (And (Local1, 0x02)) {}
            If (And (Local1, 0x04))
            {
                And (INP1, 0x04, Local0)
                If (LEqual (Local0, 0x04))
                {
                    Store (0x02, \_SB.ASIM.BNE1)
                    Store (0x02, \_SB.ASIM.BNS1)
                }
                Else
                {
                    Store (One, \_SB.ASIM.BNE1)
                    Store (One, \_SB.ASIM.BNS1)
                }
            }

            If (And (Local1, 0x08))
            {
                And (INP1, 0x08, Local0)
                If (LEqual (Local0, 0x08))
                {
                    Store (0x02, \_SB.ASIM.BNE2)
                    Store (0x02, \_SB.ASIM.BNS2)
                }
                Else
                {
                    Store (One, \_SB.ASIM.BNE2)
                    Store (One, \_SB.ASIM.BNS2)
                }
            }

            If (And (Local1, 0x10))
            {
                And (INP1, 0x10, Local0)
                If (LEqual (Local0, 0x10))
                {
                    Store (0x02, \_SB.ASIM.BNE3)
                    Store (0x02, \_SB.ASIM.BNS3)
                }
                Else
                {
                    Store (One, \_SB.ASIM.BNE3)
                    Store (One, \_SB.ASIM.BNS3)
                }
            }

            If (And (Local1, 0x20))
            {
                And (INP1, 0x20, Local0)
                If (LEqual (Local0, 0x20))
                {
                    Store (0x02, \_SB.ASIM.BNE4)
                    Store (0x02, \_SB.ASIM.BNS4)
                }
                Else
                {
                    Store (One, \_SB.ASIM.BNE4)
                    Store (One, \_SB.ASIM.BNS4)
                }
            }

            If (And (Local1, 0x40))
            {
                And (INP1, 0x40, Local0)
                If (LEqual (Local0, 0x40))
                {
                    Store (0x02, \_SB.ASIM.BNEE)
                    Store (0x02, \_SB.ASIM.BNSE)
                }
                Else
                {
                    Store (One, \_SB.ASIM.BNEE)
                    Store (One, \_SB.ASIM.BNSE)
                }
            }

            If (And (Local1, 0x80))
            {
                And (INP1, 0x80, Local0)
                If (LEqual (Local0, 0x80))
                {
                    Store (0x02, \_SB.ASIM.BNEC)
                    Store (0x02, \_SB.ASIM.BNSC)
                }
                Else
                {
                    Store (One, \_SB.ASIM.BNEC)
                    Store (One, \_SB.ASIM.BNSC)
                }
            }
        }

        BTNL ()
    }

    Name (_S0, Package (0x04)
    {
        Zero, 
        Zero, 
        Zero, 
        Zero
    })
    Name (_S1, Package (0x04)
    {
        One, 
        One, 
        Zero, 
        Zero
    })
    Name (_S3, Package (0x04)
    {
        0x03, 
        0x03, 
        Zero, 
        Zero
    })
    Name (_S5, Package (0x04)
    {
        0x05, 
        0x05, 
        Zero, 
        Zero
    })
    Name (_SB.ZZY2, Zero)
    Name (ZZY1, Zero)
    Name (ZZY3, Zero)
    Name (ZZY4, Zero)
    Name (ZZY5, Zero)
    Name (ZZY6, Zero)
    Method (ZZY0, 4, NotSerialized)
    {
        VSAA (0x08, 0x0E, Arg1)
        VSAA (0x08, 0x0F, Arg2)
        VSAA (0x08, 0x10, Arg3)
        VSAA (0x08, 0x0D, Arg0)
        Store (VSA8 (0x08, 0x11), Local0)
        Return (Local0)
    }

    Method (_PTS, 1, NotSerialized)
    {
        DBGO ("### System transitioning from S0 to S")
        DBGO (Arg0)
        DBGO (" ###\n")
        Store (Arg0, \_SB.ZZY2)
        VSAA (0x16, 0x30, BRSV)
        Store (VSA8 (0x16, 0x34), Local0)
        If (LEqual (Local0, Zero))
        {
            VSAA (0x16, 0x34, One)
            VSAA (0x16, 0x35, One)
        }
    }

    Method (_GTS, 1, NotSerialized)
    {
        DBGO ("### System transitioning from S0 to S")
        DBGO (Arg0)
        DBGO (" ###\n")
    }

    Method (_BFS, 1, NotSerialized)
    {
        DBGO ("### System transitioning from S")
        DBGO (Arg0)
        DBGO (" to S0 ###\n")
    }

    Method (_WAK, 1, NotSerialized)
    {
        DBGO ("### System transitioning from S")
        DBGO (Arg0)
        DBGO (" to S0 ###\n")
        Store (Zero, \_SB.ZZY2)
        Store (Arg0, _T00)
        If (LEqual (One, _T00))
        {
            Notify (\_SB.PCI0.USB0, Zero)
            Notify (\_SB.PCI0.USB1, Zero)
        }
        Else
        {
            If (LEqual (0x03, _T00))
            {
                Notify (\_SB.PCI0, Zero)
            }
        }

        Return (Zero)
    }

    Scope (_GPE)
    {
        Method (_L05, 0, NotSerialized)
        {
            Notify (\_SB.PCI0.USB0, 0x02)
        }

        Method (_L06, 0, NotSerialized)
        {
            Notify (\_SB.PCI0.USB1, 0x02)
        }

        Method (_L14, 0, NotSerialized)
        {
            Notify (\_SB.AC, 0x80)
        }

        Method (_L15, 0, NotSerialized)
        {
            Store (VSA8 (0x16, 0x02), Local0)
            VSAA (0x16, 0x02, Local0)
            Store (VSA8 (0x16, 0x04), Local0)
            ShiftRight (Local0, 0x08, Local1)
            And (Local0, 0xFF, Local0)
            BNSV (Local0, Local1)
        }
    }

    Scope (_SI)
    {
        Method (_SST, 1, NotSerialized)
        {
            DBGO ("   New Indicator state: ")
            DBGO (Arg0)
            DBGO ("\n")
            Store (Arg0, _T01)
            If (LEqual (Zero, _T01))
            {
                ZZY0 (0x05, Zero, Zero, 0x05)
            }
            Else
            {
                If (LEqual (One, _T01))
                {
                    ZZY0 (0x05, Zero, Zero, 0x05)
                }
                Else
                {
                    If (LEqual (0x02, _T01))
                    {
                        ZZY0 (0x05, Zero, 0x50, 0x05)
                    }
                    Else
                    {
                        If (LEqual (0x03, _T01))
                        {
                            ZZY0 (0x05, Zero, 0x32, 0x0A)
                        }
                        Else
                        {
                            If (LEqual (0x04, _T01))
                            {
                                ZZY0 (0x05, Zero, 0x46, 0x0F)
                            }
                        }
                    }
                }
            }

            Store (Arg0, ZZY1)
        }
    }

    Scope (_SB)
    {
        Method (MIN, 2, NotSerialized)
        {
            If (LLess (Arg0, Arg1))
            {
                Return (Arg0)
            }
            Else
            {
                Return (Arg1)
            }
        }

        Method (SLEN, 1, NotSerialized)
        {
            Store (Arg0, Local0)
            Return (SizeOf (Local0))
        }

        Method (S2BF, 1, NotSerialized)
        {
            Store (Arg0, Local0)
            Add (SLEN (Local0), One, Local0)
            Name (BUFF, Buffer (Local0) {})
            Store (Arg0, BUFF)
            Return (BUFF)
        }

        Method (SCMP, 2, NotSerialized)
        {
            Store (Arg0, Local0)
            Store (S2BF (Local0), Local0)
            Store (S2BF (Arg1), Local1)
            Store (Zero, Local4)
            Store (SLEN (Arg0), Local5)
            Store (SLEN (Arg1), Local6)
            Store (MIN (Local5, Local6), Local7)
            While (LLess (Local4, Local7))
            {
                Store (DerefOf (Index (Local0, Local4)), Local2)
                Store (DerefOf (Index (Local1, Local4)), Local3)
                If (LGreater (Local2, Local3))
                {
                    Return (One)
                }
                Else
                {
                    If (LLess (Local2, Local3))
                    {
                        Return (Ones)
                    }
                }

                Increment (Local4)
            }

            If (LLess (Local4, Local5))
            {
                Return (One)
            }
            Else
            {
                If (LLess (Local4, Local6))
                {
                    Return (Ones)
                }
                Else
                {
                    Return (Zero)
                }
            }
        }

        Method (I2BM, 1, NotSerialized)
        {
            Store (Zero, Local0)
            If (LNot (LEqual (Arg0, Zero)))
            {
                Store (One, Local1)
                ShiftLeft (Local1, Arg0, Local0)
            }

            Return (Local0)
        }

        Name (PABM, 0x0800)
        Name (PBBM, 0x20)
        Name (PCBM, 0x0200)
        Name (PDBM, 0x0400)
        Method (_INI, 0, NotSerialized)
        {
            If (LEqual (ZZY3, One))
            {
                Return (Store (One, ZZY3))
            }

            DBGO ("\\_SB\\_INI\n")
            DBGO ("   DSDT.ASL code from ")
            DBGO ("May 20 2005")
            DBGO (" ")
            DBGO ("11:44:11")
            DBGO ("\n   Sleep states supported: ")
            DBGO ("S1 ")
            DBGO ("S3 ")
            DBGO ("\n")
            DBGO ("   \\_OS=")
            DBGO (_OS)
            DBGO ("\n   \\_REV=")
            DBGO (_REV)
            DBGO ("\n")
            CreateWordField (^LNKA._PRS, One, IBMA)
            CreateWordField (^LNKB._PRS, One, IBMB)
            CreateWordField (^LNKC._PRS, One, IBMC)
            CreateWordField (^LNKD._PRS, One, IBMD)
            OperationRegion (QQH1, SystemMemory, 0x040E, 0x02)
            Field (QQH1, WordAcc, NoLock, Preserve)
            {
                QQH2,   16
            }

            Store (VSA8 (0x08, 0x08), Local0)
            And (Local0, 0x0F, Local1)
            If (Local1)
            {
                Store (One, Local2)
                ShiftLeft (Local2, Local1, Local2)
            }
            Else
            {
                Store (Zero, Local2)
            }

            Store (Local2, PABM)
            Store (Local2, IBMA)
            And (Local0, 0xF0, Local1)
            ShiftRight (Local1, 0x04, Local1)
            If (Local1)
            {
                Store (One, Local2)
                ShiftLeft (Local2, Local1, Local2)
            }
            Else
            {
                Store (Zero, Local2)
            }

            Store (Local2, PBBM)
            Store (Local2, IBMB)
            And (Local0, 0x0F00, Local1)
            ShiftRight (Local1, 0x08, Local1)
            If (Local1)
            {
                Store (One, Local2)
                ShiftLeft (Local2, Local1, Local2)
            }
            Else
            {
                Store (Zero, Local2)
            }

            Store (Local2, PCBM)
            Store (Local2, IBMC)
            And (Local0, 0xF000, Local1)
            ShiftRight (Local1, 0x0C, Local1)
            If (Local1)
            {
                Store (One, Local2)
                ShiftLeft (Local2, Local1, Local2)
            }
            Else
            {
                Store (Zero, Local2)
            }

            Store (Local2, PDBM)
            Store (Local2, IBMD)
            Store (QQH2, Local0)
            DBGO ("EBDA Segment=")
            DBGW (Local0)
            DBGO ("\n")
            ShiftLeft (Local0, 0x04, ZZY4)
            DBGO ("EBDA linear address=")
            DBGD (ZZY4)
            DBGO ("\n")
            OperationRegion (EBDA, SystemMemory, ZZY4, 0x0400)
            Field (EBDA, AnyAcc, NoLock, Preserve)
            {
                AccessAs (ByteAcc, 0x00), 
                QQE1,   8, 
                Offset (0x180), 
                AccessAs (DWordAcc, 0x00), 
                QQE2,   32
            }

            Store (QQE1, Local0)
            Multiply (Local0, 0x0400, ZZY5)
            DBGO ("EBDA size=")
            DBGW (ZZY5)
            DBGO ("\n")
            Store (QQE2, ZZY6)
            DBGO ("Memory Size from ebda=")
            DBGD (ZZY6)
            DBGO ("K\n")
            DBGO ("Memory Size from ebda=")
            DBGD (ShiftLeft (ZZY6, 0x0A))
            DBGO (" bytes\n")
        }

        OperationRegion (GPIO, SystemIO, 0x6100, 0x0100)
        Field (GPIO, DWordAcc, NoLock, Preserve)
        {
            GLOV,   32, 
            GLOE,   32, 
            Offset (0x18), 
            GLPU,   32, 
            Offset (0x20), 
            GLIE,   32, 
            GLII,   32, 
            Offset (0x30), 
            GRBK,   32, 
            Offset (0x38), 
            GLEE,   32
        }

        Device (LNKA)
        {
            Name (_HID, EisaId ("PNP0C0F"))
            Name (_UID, One)
            Name (BCRS, ResourceTemplate ()
            {
                IRQ (Level, ActiveLow, Shared) {11}
            })
            Name (_PRS, ResourceTemplate ()
            {
                IRQ (Level, ActiveLow, Shared) {11}
            })
            Method (_STA, 0, NotSerialized)
            {
                CreateDWordField (_PRS, Zero, PRSA)
                Store (Zero, Local0)
                If (LNot (LEqual (PABM, Zero)))
                {
                    Store (^^PCI0.SBF0.PRCN (Zero, Zero, Zero), Local1)
                    If (LEqual (Local1, Zero))
                    {
                        Store (0x09, Local0)
                    }
                    Else
                    {
                        Store (0x0B, Local0)
                    }
                }

                Return (Local0)
            }

            Method (_DIS, 0, NotSerialized)
            {
                ^^PCI0.SBF0.PRCN (One, Zero, Zero)
            }

            Method (_CRS, 0, NotSerialized)
            {
                CreateWordField (BCRS, One, IRQM)
                CreateByteField (BCRS, 0x03, E_LT)
                Store (^^PCI0.SBF0.PRCN (Zero, Zero, Zero), Local0)
                Store (I2BM (Local0), Local1)
                Store (Local1, IRQM)
                Store (0x18, E_LT)
                Return (BCRS)
            }

            Method (_SRS, 1, NotSerialized)
            {
                CreateWordField (Arg0, One, IRQM)
                If (And (IRQM, PABM))
                {
                    FindSetLeftBit (IRQM, Local0)
                    If (Local0)
                    {
                        Decrement (Local0)
                    }

                    ^^PCI0.SBF0.PRCN (One, Zero, Local0)
                }
            }
        }

        Device (LNKB)
        {
            Name (_HID, EisaId ("PNP0C0F"))
            Name (_UID, 0x02)
            Name (BCRS, ResourceTemplate ()
            {
                IRQ (Level, ActiveLow, Shared) {5}
            })
            Name (_PRS, ResourceTemplate ()
            {
                IRQ (Level, ActiveLow, Shared) {5}
            })
            Method (_STA, 0, NotSerialized)
            {
                CreateDWordField (_PRS, Zero, PRSB)
                Store (Zero, Local0)
                If (LNot (LEqual (PBBM, Zero)))
                {
                    Store (^^PCI0.SBF0.PRCN (Zero, One, Zero), Local1)
                    If (LEqual (Local1, Zero))
                    {
                        Store (0x09, Local0)
                    }
                    Else
                    {
                        Store (0x0B, Local0)
                    }
                }

                Return (Local0)
            }

            Method (_DIS, 0, NotSerialized)
            {
                ^^PCI0.SBF0.PRCN (One, One, Zero)
            }

            Method (_CRS, 0, NotSerialized)
            {
                CreateWordField (BCRS, One, IRQM)
                CreateByteField (BCRS, 0x03, E_LT)
                Store (^^PCI0.SBF0.PRCN (Zero, One, Zero), Local0)
                Store (I2BM (Local0), Local1)
                Store (Local1, IRQM)
                Store (0x18, E_LT)
                Return (BCRS)
            }

            Method (_SRS, 1, NotSerialized)
            {
                CreateWordField (Arg0, One, IRQM)
                If (And (IRQM, PBBM))
                {
                    FindSetLeftBit (IRQM, Local0)
                    If (Local0)
                    {
                        Decrement (Local0)
                    }

                    ^^PCI0.SBF0.PRCN (One, One, Local0)
                }
            }
        }

        Device (LNKC)
        {
            Name (_HID, EisaId ("PNP0C0F"))
            Name (_UID, 0x03)
            Name (BCRS, ResourceTemplate ()
            {
                IRQ (Level, ActiveLow, Shared) {9}
            })
            Name (_PRS, ResourceTemplate ()
            {
                IRQ (Level, ActiveLow, Shared) {9}
            })
            Method (_STA, 0, NotSerialized)
            {
                CreateDWordField (_PRS, Zero, PRSC)
                Store (Zero, Local0)
                If (LNot (LEqual (PCBM, Zero)))
                {
                    Store (^^PCI0.SBF0.PRCN (Zero, 0x02, Zero), Local1)
                    If (LEqual (Local1, Zero))
                    {
                        Store (0x09, Local0)
                    }
                    Else
                    {
                        Store (0x0B, Local0)
                    }
                }

                Return (Local0)
            }

            Method (_DIS, 0, NotSerialized)
            {
                ^^PCI0.SBF0.PRCN (One, 0x02, Zero)
            }

            Method (_CRS, 0, NotSerialized)
            {
                CreateWordField (BCRS, One, IRQM)
                CreateByteField (BCRS, 0x03, E_LT)
                Store (^^PCI0.SBF0.PRCN (Zero, 0x02, Zero), Local0)
                Store (I2BM (Local0), Local1)
                Store (Local1, IRQM)
                Store (0x18, E_LT)
                Return (BCRS)
            }

            Method (_SRS, 1, NotSerialized)
            {
                CreateWordField (Arg0, One, IRQM)
                If (And (IRQM, PCBM))
                {
                    FindSetLeftBit (IRQM, Local0)
                    If (Local0)
                    {
                        Decrement (Local0)
                    }

                    ^^PCI0.SBF0.PRCN (One, 0x02, Local0)
                }
            }
        }

        Device (LNKD)
        {
            Name (_HID, EisaId ("PNP0C0F"))
            Name (_UID, 0x04)
            Name (BCRS, ResourceTemplate ()
            {
                IRQ (Level, ActiveLow, Shared) {10}
            })
            Name (_PRS, ResourceTemplate ()
            {
                IRQ (Level, ActiveLow, Shared) {10}
            })
            Method (_STA, 0, NotSerialized)
            {
                CreateDWordField (_PRS, Zero, PRSD)
                Store (Zero, Local0)
                If (LNot (LEqual (PDBM, Zero)))
                {
                    Store (^^PCI0.SBF0.PRCN (Zero, 0x03, Zero), Local1)
                    If (LEqual (Local1, Zero))
                    {
                        Store (0x09, Local0)
                    }
                    Else
                    {
                        Store (0x0B, Local0)
                    }
                }

                Return (Local0)
            }

            Method (_DIS, 0, NotSerialized)
            {
                ^^PCI0.SBF0.PRCN (One, 0x03, Zero)
            }

            Method (_CRS, 0, NotSerialized)
            {
                CreateWordField (BCRS, One, IRQM)
                CreateByteField (BCRS, 0x03, E_LT)
                Store (^^PCI0.SBF0.PRCN (Zero, 0x03, Zero), Local0)
                Store (I2BM (Local0), Local1)
                Store (Local1, IRQM)
                Store (0x18, E_LT)
                Return (BCRS)
            }

            Method (_SRS, 1, NotSerialized)
            {
                CreateWordField (Arg0, One, IRQM)
                If (And (IRQM, PDBM))
                {
                    FindSetLeftBit (IRQM, Local0)
                    If (Local0)
                    {
                        Decrement (Local0)
                    }

                    ^^PCI0.SBF0.PRCN (One, 0x03, Local0)
                }
            }
        }

        Device (AC)
        {
            Name (_HID, "ACPI0003")
            Name (_PCL, Package (0x01)
            {
                _SB
            })
            Method (_PSR, 0, NotSerialized)
            {
                Store (BATI (0xF0), Local0)
                If (LEqual (Local0, One))
                {
                    Return (Zero)
                }
                Else
                {
                    Return (One)
                }
            }
        }

        Device (PCI0)
        {
            Name (_HID, EisaId ("PNP0A03"))
            Name (_ADR, Zero)
            Name (_PRW, Package (0x02)
            {
                0x1F, 
                0x05
            })
            Method (_INI, 0, NotSerialized)
            {
            }

            Method (_STA, 0, NotSerialized)
            {
                Return (0x0F)
            }

            Name (_PRT, Package (0x0A)
            {
                Package (0x04)
                {
                    0x000FFFFF, 
                    Zero, 
                    LNKA, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x000FFFFF, 
                    One, 
                    LNKB, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x000FFFFF, 
                    0x02, 
                    LNKC, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x000FFFFF, 
                    0x03, 
                    LNKD, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x000DFFFF, 
                    Zero, 
                    LNKA, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x000DFFFF, 
                    One, 
                    LNKB, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x000EFFFF, 
                    Zero, 
                    LNKB, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x000EFFFF, 
                    One, 
                    LNKC, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x000EFFFF, 
                    0x02, 
                    LNKD, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x000EFFFF, 
                    0x03, 
                    LNKA, 
                    Zero
                }
            })
            Name (CRES, ResourceTemplate ()
            {
                WordBusNumber (ResourceConsumer, MinNotFixed, MaxNotFixed, PosDecode,
                    0x0000, // Address Space Granularity
                    0x0000, // Address Range Minimum
                    0x00FF, // Address Range Maximum
                    0x0000, // Address Translation Offset
                    0x0100,,,)
                IO (Decode16, 0x0CF8, 0x0CF8, 0x01, 0x08)
                WordIO (ResourceProducer, MinFixed, MaxFixed, PosDecode, EntireRange,
                    0x0000, // Address Space Granularity
                    0x0000, // Address Range Minimum
                    0x0CF7, // Address Range Maximum
                    0x0000, // Address Translation Offset
                    0x0CF8,,,
                    , TypeStatic)
                WordIO (ResourceProducer, MinFixed, MaxFixed, PosDecode, EntireRange,
                    0x0000, // Address Space Granularity
                    0x0D00, // Address Range Minimum
                    0xAC17, // Address Range Maximum
                    0x0000, // Address Translation Offset
                    0x9F18,,,
                    , TypeStatic)
                WordIO (ResourceProducer, MinFixed, MaxFixed, PosDecode, EntireRange,
                    0x0000, // Address Space Granularity
                    0xAC20, // Address Range Minimum
                    0xFFFF, // Address Range Maximum
                    0x0000, // Address Translation Offset
                    0x53E0,,,
                    , TypeStatic)
                DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                    0x00000000, // Address Space Granularity
                    0x000A0000, // Address Range Minimum
                    0x000BFFFF, // Address Range Maximum
                    0x00000000, // Address Translation Offset
                    0x00020000,,,
                    , AddressRangeMemory, TypeStatic)
                DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                    0x00000000, // Address Space Granularity
                    0x000C8000, // Address Range Minimum
                    0x000DFFFF, // Address Range Maximum
                    0x00000000, // Address Translation Offset
                    0x00018000,,,
                    , AddressRangeMemory, TypeStatic)
                DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                    0x00000000, // Address Space Granularity
                    0x04000000, // Address Range Minimum
                    0x403FFFFF, // Address Range Maximum
                    0x00000000, // Address Translation Offset
                    0x3C400000,,,
                    , AddressRangeMemory, TypeStatic)
                DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                    0x00000000, // Address Space Granularity
                    0x40500000, // Address Range Minimum
                    0xEFFFFFFF, // Address Range Maximum
                    0x00000000, // Address Translation Offset
                    0xAFB00000,,,
                    , AddressRangeMemory, TypeStatic)
            })
            Method (_CRS, 0, NotSerialized)
            {
                CreateDWordField (CRES, 0x87, RMIN)
                CreateDWordField (CRES, 0x8B, RMAX)
                CreateDWordField (CRES, 0x93, RLEN)
                Store (ZZY6, Local0)
                Add (Local0, 0x40, Local0)
                ShiftLeft (Local0, 0x0A, RMIN)
                Subtract (RMAX, RMIN, Local1)
                Increment (Local1)
                Store (Local1, RLEN)
                Return (CRES)
            }

            Device (SVG)
            {
                Name (_ADR, 0x00010001)
                Name (_UID, Zero)
                Method (_STA, 0, NotSerialized)
                {
                    Store (VSA8 (0x02, One), Local0)
                    If (LEqual (And (Local0, One), One))
                    {
                        Return (0x0F)
                    }
                    Else
                    {
                        Return (0x09)
                    }
                }

                Device (LCD)
                {
                    Name (_HID, "ACPILCD00")
                    Method (_ADR, 0, NotSerialized)
                    {
                        Return (0x0110)
                    }

                    Method (_INI, 0, NotSerialized)
                    {
                        And (GLIE, 0xFFFFDFBF, Local0)
                        Or (Local0, 0x20400000, GLIE)
                        And (GLII, 0xFFFFDFBF, Local0)
                        Or (Local0, 0x20400000, GLII)
                        And (GLEE, 0xFFFFDFBF, Local0)
                        Or (Local0, 0x20400000, GLEE)
                        And (GLOE, 0xDFBFFFFF, Local0)
                        Or (Local0, 0x2040, GLOE)
                        And (GLPU, 0xFFFFDFBF, Local0)
                        Or (Local0, 0x20400000, GLPU)
                        And (GLOV, 0xFFBFDFFF, Local0)
                        Or (Local0, 0x20000040, GLOV)
                        Sleep (0x0BB8)
                        And (GLOV, 0xDFBFFFFF, Local0)
                        Or (Local0, 0x2040, GLOV)
                        Store (VSA8 (0x16, 0x30), BRSV)
                        If (LNot (LLess (BRSV, 0x20)))
                        {
                            Store (0x1F, BRSV)
                        }

                        Store (One, Local0)
                        While (LNot (LGreater (Local0, BRSV)))
                        {
                            SBRL (One, One)
                            Increment (Local0)
                        }
                    }

                    Method (_BCL, 0, NotSerialized)
                    {
                        Return (Package (0x02)
                        {
                            0x1F, 
                            0x1F
                        })
                    }

                    Method (_BCM, 1, NotSerialized)
                    {
                        Store (Arg0, Local0)
                        Store (RBRL (), Local1)
                        And (Local1, 0xFF, Local1)
                        If (LAnd (LNot (LLess (Local0, Zero)), LNot (LGreater (Local0, Local1))))
                        {
                            Store (BRSV, Local1)
                            And (Local1, 0xFF, Local1)
                            While (LNot (LEqual (Arg0, BRSV)))
                            {
                                If (LGreater (Arg0, BRSV))
                                {
                                    SBRL (One, One)
                                    Increment (BRSV)
                                }
                                Else
                                {
                                    If (LEqual (Arg0, BRSV))
                                    {
                                        Break
                                    }
                                    Else
                                    {
                                        SBRL (Zero, One)
                                        Decrement (BRSV)
                                    }
                                }
                            }
                        }
                    }
                }
            }

            Device (SBF0)
            {
                Name (_ADR, 0x000F0000)
                Method (_INI, 0, NotSerialized)
                {
                    ^^^_INI ()
                }

                Method (PRCN, 3, NotSerialized)
                {
                    Store (VSA8 (0x08, 0x06), Local0)
                    Multiply (Arg1, 0x04, Local1)
                    If (LEqual (Arg0, Zero))
                    {
                        ShiftRight (Local0, Local1, Local2)
                        And (Local2, 0x0F, Local2)
                        Return (Local2)
                    }
                    Else
                    {
                        And (Arg2, 0x0F, Local2)
                        ShiftLeft (Local2, Local1, Local2)
                        Store (0x0F, Local3)
                        ShiftLeft (Local3, Local1, Local3)
                        Not (Local3, Local4)
                        And (Local0, Local4, Local0)
                        Or (Local0, Local2, Local0)
                        VSAA (0x08, 0x06, Local0)
                        Return (Arg2)
                    }
                }

                Device (RTC0)
                {
                    Name (_HID, EisaId ("PNP0B00"))
                    Name (_UID, Zero)
                    Method (_STA, 0, NotSerialized)
                    {
                        Return (0x0F)
                    }

                    Name (CRSB, ResourceTemplate ()
                    {
                        IRQNoFlags () {8}
                        IO (Decode16, 0x0070, 0x0070, 0x00, 0x04)
                    })
                    Method (_CRS, 0, NotSerialized)
                    {
                        Return (CRSB)
                    }
                }

                Device (TMR)
                {
                    Name (_HID, EisaId ("PNP0100"))
                    Name (_STA, 0x0F)
                    Name (CRSB, ResourceTemplate ()
                    {
                        IRQNoFlags () {0}
                        IO (Decode16, 0x0040, 0x0040, 0x00, 0x04)
                        IO (Decode16, 0x0048, 0x0048, 0x00, 0x04)
                    })
                    Method (_CRS, 0, NotSerialized)
                    {
                        Return (CRSB)
                    }
                }

                Device (SPKR)
                {
                    Name (_HID, EisaId ("PNP0800"))
                    Name (_STA, 0x0F)
                    Name (CRSB, ResourceTemplate ()
                    {
                        IO (Decode16, 0x0061, 0x0061, 0x00, 0x01)
                    })
                    Method (_CRS, 0, NotSerialized)
                    {
                        Return (CRSB)
                    }
                }

                Device (MEM)
                {
                    Name (_HID, EisaId ("PNP0C01"))
                    Name (_UID, One)
                    Method (_CRS, 0, NotSerialized)
                    {
                        Name (MBRB, ResourceTemplate ()
                        {
                            Memory32Fixed (ReadWrite, 0x00000000, 0x000A0000)
                            Memory32Fixed (ReadOnly, 0x000E0000, 0x00020000)
                            Memory32Fixed (ReadWrite, 0x00100000, 0x00000000)
                            Memory32Fixed (ReadOnly, 0x40400000, 0x00020000)
                            Memory32Fixed (ReadOnly, 0xF0000000, 0x10000000)
                            IO (Decode16, 0x0092, 0x0092, 0x00, 0x01)
                        })
                        CreateDWordField (MBRB, 0x20, EM1L)
                        Store (ZZY6, Local0)
                        Subtract (Local0, 0x0400, Local0)
                        ShiftLeft (Local0, 0x0A, Local0)
                        Store (Local0, EM1L)
                        Return (MBRB)
                    }
                }

                Device (PIC)
                {
                    Name (_HID, EisaId ("PNP0000"))
                    Name (_STA, 0x0F)
                    Name (CRSB, ResourceTemplate ()
                    {
                        IRQNoFlags () {2}
                        IO (Decode16, 0x0020, 0x0020, 0x00, 0x02)
                        IO (Decode16, 0x00A0, 0x00A0, 0x00, 0x02)
                        IO (Decode16, 0x04D0, 0x04D0, 0x10, 0x02)
                    })
                    Method (_CRS, 0, NotSerialized)
                    {
                        Return (CRSB)
                    }
                }

                Device (MAD)
                {
                    Name (_HID, EisaId ("PNP0200"))
                    Name (_STA, 0x0F)
                    Name (MADR, ResourceTemplate ()
                    {
                        DMA (Compatibility, BusMaster, Transfer8) {4}
                        IO (Decode16, 0x0000, 0x0000, 0x10, 0x10)
                        IO (Decode16, 0x0080, 0x0080, 0x10, 0x10)
                        IO (Decode16, 0x00C0, 0x00C0, 0x10, 0x20)
                        IO (Decode16, 0x0480, 0x0480, 0x10, 0x10)
                    })
                    Method (_CRS, 0, NotSerialized)
                    {
                        Return (MADR)
                    }
                }

                Device (COPR)
                {
                    Name (_HID, EisaId ("PNP0C04"))
                    Name (CPRS, ResourceTemplate ()
                    {
                        IO (Decode16, 0x00F0, 0x00F0, 0x10, 0x10)
                        IRQNoFlags () {13}
                    })
                    Method (_CRS, 0, NotSerialized)
                    {
                        Return (CPRS)
                    }
                }

                OperationRegion (XXY, SystemIO, 0x2E, 0x02)
                Field (XXY, ByteAcc, NoLock, Preserve)
                {
                    XXY0,   8, 
                    XXY1,   8
                }

                IndexField (XXY0, XXY1, ByteAcc, NoLock, Preserve)
                {
                    Offset (0x07), 
                    XXY2,   8, 
                    Offset (0x20), 
                    XXY3,   8, 
                    XXY4,   8, 
                    XXY5,   8, 
                    XXY6,   8, 
                    XXY7,   8, 
                    XXY8,   8, 
                    XXY9,   8, 
                    XXYA,   8, 
                    XXYB,   8, 
                    XXYC,   8, 
                    XXYD,   8, 
                    Offset (0x30), 
                    XXYE,   8, 
                    Offset (0x60), 
                    XXYF,   8, 
                    XXYG,   8, 
                    XXYH,   8, 
                    XXYI,   8, 
                    Offset (0x70), 
                    XXYJ,   8, 
                    XXYK,   8, 
                    Offset (0x74), 
                    XXYL,   8, 
                    XXYM,   8, 
                    Offset (0xF0), 
                    XXYN,   8, 
                    Offset (0xF4), 
                    DSS1,   8, 
                    DSS2,   8, 
                    DSS3,   8
                }

                Mutex (XXX0, 0x00)
                Method (XXX1, 0, NotSerialized)
                {
                    Acquire (XXX0, 0xFFFF)
                }

                Method (XXX2, 0, NotSerialized)
                {
                    Release (XXX0)
                }

                Name (XXYO, 0xFF)
                Name (XXYP, Zero)
                Name (XXYQ, Zero)
                Method (XXXA, 1, NotSerialized)
                {
                    Store (0x80000000, Local0)
                    If (LEqual (XXYO, One))
                    {
                        XXX1 ()
                        Store (Arg0, XXY2)
                        Store (XXYE, Local0)
                        Store (0x0A, XXY2)
                        XXX2 ()
                    }

                    Return (Local0)
                }

                Method (XXXB, 2, NotSerialized)
                {
                    If (LEqual (XXYO, One))
                    {
                        XXX1 ()
                        Store (Arg0, XXY2)
                        Store (Arg1, XXYE)
                        Store (0x0A, XXY2)
                        XXX2 ()
                    }
                }

                Method (XXXC, 1, NotSerialized)
                {
                    Store (Zero, Local0)
                    If (LEqual (XXYO, One))
                    {
                        XXX1 ()
                        Store (Arg0, XXY2)
                        Store (XXYF, Local1)
                        Store (XXYG, Local2)
                        ShiftLeft (Local1, 0x08, Local1)
                        Or (Local1, Local2, Local0)
                        Store (0x0A, XXY2)
                        XXX2 ()
                    }

                    Return (Local0)
                }

                Method (XXXD, 2, NotSerialized)
                {
                    If (LEqual (XXYO, One))
                    {
                        XXX1 ()
                        Store (Arg0, XXY2)
                        And (Arg1, 0xFF, Local0)
                        ShiftRight (Arg1, 0x08, Local1)
                        Store (Local0, XXYG)
                        Store (Local1, XXYF)
                        Store (0x0A, XXY2)
                        XXX2 ()
                    }
                }

                Method (XXXE, 1, NotSerialized)
                {
                    Store (Zero, Local0)
                    If (LEqual (XXYO, One))
                    {
                        XXX1 ()
                        Store (Arg0, XXY2)
                        Store (XXYK, Local1)
                        Store (XXYJ, Local2)
                        ShiftLeft (Local1, 0x08, Local1)
                        Or (Local1, Local2, Local0)
                        Store (0x0A, XXY2)
                        XXX2 ()
                    }

                    Return (Local0)
                }

                Method (XXXF, 2, NotSerialized)
                {
                    If (LEqual (XXYO, One))
                    {
                        XXX1 ()
                        Store (Arg0, XXY2)
                        And (Arg1, 0xFF, Local0)
                        ShiftRight (Arg1, 0x08, Local1)
                        Store (Local0, XXYJ)
                        Store (Local1, XXYK)
                        Store (0x0A, XXY2)
                        XXX2 ()
                    }
                }

                Method (XXXG, 1, NotSerialized)
                {
                    Store (Zero, Local0)
                    If (LEqual (XXYO, One))
                    {
                        XXX1 ()
                        Store (Arg0, XXY2)
                        Store (XXYM, Local1)
                        Store (XXYL, Local2)
                        ShiftLeft (Local1, 0x08, Local1)
                        Or (Local1, Local2, Local0)
                        Store (0x0A, XXY2)
                        XXX2 ()
                    }

                    Return (Local0)
                }

                Method (XXXH, 2, NotSerialized)
                {
                    If (LEqual (XXYO, One))
                    {
                        XXX1 ()
                        Store (Arg0, XXY2)
                        And (Arg1, 0xFF, Local0)
                        ShiftRight (Arg1, 0x08, Local1)
                        Store (Local0, XXYL)
                        Store (Local1, XXYM)
                        Store (0x0A, XXY2)
                        XXX2 ()
                    }
                }

                Method (XXXI, 1, NotSerialized)
                {
                    Store (Zero, Local0)
                    If (LEqual (XXYO, One))
                    {
                        XXX1 ()
                        Store (Arg0, XXY2)
                        Store (XXYN, Local0)
                        Store (0x0A, XXY2)
                        XXX2 ()
                    }

                    Return (Local0)
                }

                Method (XXXJ, 2, NotSerialized)
                {
                    If (LEqual (XXYO, One))
                    {
                        XXX1 ()
                        Store (Arg0, XXY2)
                        Store (Arg1, XXYN)
                        Store (0x0A, XXY2)
                        XXX2 ()
                    }
                }

                Method (XXXK, 1, NotSerialized)
                {
                    Store (XXXA (Arg0), Local0)
                    If (And (Local0, 0x80000000))
                    {
                        Store (Zero, Local1)
                    }
                    Else
                    {
                        If (And (Local0, One))
                        {
                            Store (0x0F, Local1)
                        }
                        Else
                        {
                            Store (0x0D, Local1)
                        }
                    }

                    Return (Local1)
                }

                Method (XXXL, 1, NotSerialized)
                {
                    Store (XXXE (Arg0), Local0)
                    Store (Zero, Local1)
                    And (Local0, 0x0F, Local0)
                    If (Local0)
                    {
                        Store (One, Local1)
                        ShiftLeft (Local1, Local0, Local1)
                    }

                    Return (Local1)
                }

                Method (XXXM, 2, NotSerialized)
                {
                    Store (XXXE (Arg0), Local0)
                    And (Local0, 0xFFFFFFF0, Local0)
                    If (Arg1)
                    {
                        FindSetLeftBit (Arg1, Local1)
                        Decrement (Local1)
                        And (Local1, 0x0F, Local1)
                        Or (Local0, Local1, Local0)
                    }

                    XXXF (Arg0, Local0)
                }

                Method (XXXN, 1, NotSerialized)
                {
                    Store (XXXG (Arg0), Local0)
                    Store (Zero, Local1)
                    And (Local0, 0x07, Local0)
                    If (Not (And (Local0, 0x04)))
                    {
                        Store (One, Local1)
                        ShiftLeft (Local1, Local0, Local1)
                    }

                    Return (Local1)
                }

                Method (XXXO, 2, NotSerialized)
                {
                    Store (XXXG (Arg0), Local0)
                    And (Local0, 0xFFFFFFF8, Local0)
                    Or (Local0, 0x04, Local0)
                    If (Arg1)
                    {
                        FindSetLeftBit (Arg1, Local1)
                        Decrement (Local1)
                        And (Local1, 0x03, Local1)
                        Or (Local0, Local1, Local0)
                    }

                    XXXH (Arg0, Local0)
                }

                Method (XXX3, 0, NotSerialized)
                {
                    If (LEqual (XXYO, 0xFF))
                    {
                        Store (Zero, XXYO)
                        Store (Zero, XXYP)
                        Store (Zero, XXYQ)
                        XXX1 ()
                        Store (XXY3, Local0)
                        And (Local0, 0xF0, Local0)
                        If (LEqual (Local0, 0xE0))
                        {
                            Store (One, XXYO)
                            Store (XXXC (0x03), Local0)
                            If (LNot (LEqual (Local0, Zero)))
                            {
                                Store (One, XXYP)
                            }

                            Store (XXXC (0x02), Local0)
                            If (LNot (LEqual (Local0, Zero)))
                            {
                                Store (One, XXYQ)
                            }
                        }

                        XXX2 ()
                    }
                }

                Device (XXYR)
                {
                    Name (_HID, EisaId ("PNP0C01"))
                    Name (_UID, 0x02)
                    Name (SIOR, ResourceTemplate ()
                    {
                        IO (Decode16, 0x002E, 0x002E, 0x02, 0x02)
                    })
                    Method (_STA, 0, NotSerialized)
                    {
                        XXX3 ()
                        If (LEqual (XXYO, One))
                        {
                            Store (0x0F, Local0)
                        }
                        Else
                        {
                            Store (Zero, Local0)
                        }

                        Return (Local0)
                    }

                    Method (_CRS, 0, NotSerialized)
                    {
                        Return (SIOR)
                    }
                }

                Device (KBC)
                {
                    Name (_HID, EisaId ("PNP0303"))
                    Name (_CID, 0x0B03D041)
                    Name (KCRS, ResourceTemplate ()
                    {
                        IRQNoFlags () {1}
                        IO (Decode16, 0x0060, 0x0060, 0x00, 0x01)
                        IO (Decode16, 0x0064, 0x0064, 0x00, 0x01)
                    })
                    Method (_STA, 0, NotSerialized)
                    {
                        Store (XXXK (0x06), Local0)
                        Return (Local0)
                    }

                    Method (_CRS, 0, NotSerialized)
                    {
                        Return (KCRS)
                    }
                }

                Device (PS2M)
                {
                    Name (_HID, EisaId ("PNP0F03"))
                    Name (_CID, 0x130FD041)
                    Name (MCRS, ResourceTemplate ()
                    {
                        IRQNoFlags () {12}
                    })
                    Method (_STA, 0, NotSerialized)
                    {
                        Store (XXXK (0x05), Local0)
                        Return (Local0)
                    }

                    Method (_CRS, 0, NotSerialized)
                    {
                        Return (MCRS)
                    }
                }

                Device (XXYS)
                {
                    Name (_HID, EisaId ("PNP0501"))
                    Name (_UID, 0x03)
                    Method (_STA, 0, NotSerialized)
                    {
                        Store (Zero, Local0)
                        If (LNot (LEqual (XXYP, Zero)))
                        {
                            Store (XXXK (0x03), Local0)
                        }

                        Return (Local0)
                    }

                    Method (_DIS, 0, NotSerialized)
                    {
                        XXXB (0x03, Zero)
                    }

                    Name (BCRS, ResourceTemplate ()
                    {
                        IO (Decode16, 0x03F8, 0x03F8, 0x01, 0x08)
                        IRQNoFlags () {4}
                    })
                    Method (_CRS, 0, NotSerialized)
                    {
                        CreateWordField (BCRS, 0x02, IOB0)
                        CreateWordField (BCRS, 0x04, IOB1)
                        CreateWordField (BCRS, 0x09, IRQM)
                        Store (XXXA (0x03), Local0)
                        If (LEqual (Local0, Zero))
                        {
                            Store (Zero, IOB0)
                            Store (Zero, IOB1)
                            Store (Zero, IRQM)
                        }
                        Else
                        {
                            Store (XXXC (0x03), Local1)
                            Store (Local1, IOB0)
                            Store (Local1, IOB1)
                            Store (XXXL (0x03), Local1)
                            Store (Local1, IRQM)
                        }

                        Return (BCRS)
                    }

                    Name (_PRS, ResourceTemplate ()
                    {
                        StartDependentFnNoPri ()
                        {
                            IO (Decode16, 0x03F8, 0x03F8, 0x01, 0x08)
                            IRQNoFlags () {4}
                        }
                        StartDependentFnNoPri ()
                        {
                            IO (Decode16, 0x02F8, 0x02F8, 0x01, 0x08)
                            IRQNoFlags () {3}
                        }
                        StartDependentFnNoPri ()
                        {
                            IO (Decode16, 0x03E8, 0x03E8, 0x01, 0x08)
                            IRQNoFlags () {4}
                        }
                        StartDependentFnNoPri ()
                        {
                            IO (Decode16, 0x02E8, 0x02E8, 0x01, 0x08)
                            IRQNoFlags () {3}
                        }
                        EndDependentFn ()
                    })
                    Method (_SRS, 1, NotSerialized)
                    {
                        CreateWordField (Arg0, 0x02, IOB0)
                        CreateWordField (Arg0, 0x09, IRQM)
                        _DIS ()
                        XXXD (0x03, IOB0)
                        XXXM (0x03, IRQM)
                        XXXB (0x03, One)
                    }
                }

                Device (XXYT)
                {
                    Name (_HID, EisaId ("PNP0501"))
                    Name (_UID, 0x04)
                    Method (_STA, 0, NotSerialized)
                    {
                        Store (Zero, Local0)
                        If (LNot (LEqual (XXYQ, Zero)))
                        {
                            Store (XXXK (0x02), Local0)
                        }

                        Return (Local0)
                    }

                    Method (_DIS, 0, NotSerialized)
                    {
                    }

                    Name (BCRS, ResourceTemplate ()
                    {
                        IO (Decode16, 0x02F8, 0x02F8, 0x01, 0x08)
                        IRQNoFlags () {3}
                    })
                    Method (_CRS, 0, NotSerialized)
                    {
                        CreateWordField (BCRS, 0x02, IOB0)
                        CreateWordField (BCRS, 0x04, IOB1)
                        CreateWordField (BCRS, 0x09, IRQM)
                        Store (XXXA (0x02), Local0)
                        If (LEqual (Local0, Zero))
                        {
                            Store (Zero, IOB0)
                            Store (Zero, IOB1)
                            Store (Zero, IRQM)
                        }
                        Else
                        {
                            Store (XXXC (0x02), Local1)
                            Store (Local1, IOB0)
                            Store (Local1, IOB1)
                            Store (XXXL (0x02), Local1)
                            Store (Local1, IRQM)
                        }

                        Return (BCRS)
                    }

                    Name (_PRS, ResourceTemplate ()
                    {
                        StartDependentFnNoPri ()
                        {
                        }
                        StartDependentFnNoPri ()
                        {
                            IO (Decode16, 0x02E8, 0x02E8, 0x01, 0x08)
                            IRQNoFlags () {3}
                        }
                        StartDependentFnNoPri ()
                        {
                            IO (Decode16, 0x03E8, 0x03E8, 0x01, 0x08)
                            IRQNoFlags () {4}
                        }
                        StartDependentFnNoPri ()
                        {
                            IO (Decode16, 0x02F8, 0x02F8, 0x01, 0x08)
                            IRQNoFlags () {3}
                        }
                        StartDependentFnNoPri ()
                        {
                            IO (Decode16, 0x03F8, 0x03F8, 0x01, 0x08)
                            IRQNoFlags () {4}
                        }
                        EndDependentFn ()
                    })
                    Method (_SRS, 1, NotSerialized)
                    {
                        CreateWordField (Arg0, 0x02, IOB0)
                        CreateWordField (Arg0, 0x09, IRQM)
                        _DIS ()
                        XXXD (0x02, IOB0)
                        XXXM (0x02, IRQM)
                        XXXB (0x02, One)
                    }
                }

                Device (PRT1)
                {
                    Name (_HID, EisaId ("PNP0400"))
                    Method (_STA, 0, NotSerialized)
                    {
                        Store (XXXK (One), Local0)
                        If (Local0)
                        {
                            Store (XXXI (One), Local1)
                            If (And (Local1, 0x80))
                            {
                                Return (Zero)
                            }
                        }

                        Return (Local0)
                    }

                    Method (_DIS, 0, NotSerialized)
                    {
                        XXXB (One, Zero)
                    }

                    Name (CRPP, ResourceTemplate ()
                    {
                        IO (Decode16, 0x0378, 0x0378, 0x00, 0x03)
                        IRQNoFlags () {7}
                    })
                    Method (_CRS, 0, NotSerialized)
                    {
                        CreateWordField (CRPP, 0x02, IO1)
                        CreateWordField (CRPP, 0x04, IO2)
                        CreateByteField (CRPP, 0x07, IOLN)
                        CreateWordField (CRPP, 0x09, IRQM)
                        Store (XXXA (One), Local0)
                        If (Not (And (Local0, One)))
                        {
                            Store (Zero, IO1)
                            Store (Zero, IO2)
                            Store (Zero, IOLN)
                            Store (Zero, IRQM)
                        }
                        Else
                        {
                            Store (XXXC (One), Local1)
                            Store (Local1, IO1)
                            Store (Local1, IO2)
                            If (LEqual (Local1, 0x03BC))
                            {
                                Store (0x03, IOLN)
                            }
                            Else
                            {
                                Store (0x08, IOLN)
                            }

                            Store (XXXL (One), Local1)
                            Store (Local1, IRQM)
                        }

                        Return (CRPP)
                    }

                    Name (_PRS, ResourceTemplate ()
                    {
                        StartDependentFnNoPri ()
                        {
                            IO (Decode16, 0x0378, 0x0378, 0x01, 0x08)
                            IRQNoFlags () {7}
                        }
                        StartDependentFnNoPri ()
                        {
                            IO (Decode16, 0x0278, 0x0278, 0x01, 0x08)
                            IRQNoFlags () {7}
                        }
                        StartDependentFnNoPri ()
                        {
                            IO (Decode16, 0x03BC, 0x03BC, 0x01, 0x03)
                            IRQNoFlags () {7}
                        }
                        StartDependentFnNoPri ()
                        {
                            IO (Decode16, 0x0378, 0x0378, 0x01, 0x08)
                            IRQNoFlags () {5}
                        }
                        StartDependentFnNoPri ()
                        {
                            IO (Decode16, 0x0278, 0x0278, 0x01, 0x08)
                            IRQNoFlags () {5}
                        }
                        StartDependentFnNoPri ()
                        {
                            IO (Decode16, 0x03BC, 0x03BC, 0x01, 0x03)
                            IRQNoFlags () {5}
                        }
                        StartDependentFnNoPri ()
                        {
                            IO (Decode16, 0x0378, 0x0378, 0x01, 0x08)
                            IRQNoFlags () {}
                        }
                        StartDependentFnNoPri ()
                        {
                            IO (Decode16, 0x0278, 0x0278, 0x01, 0x08)
                            IRQNoFlags () {}
                        }
                        StartDependentFnNoPri ()
                        {
                            IO (Decode16, 0x03BC, 0x03BC, 0x01, 0x03)
                            IRQNoFlags () {}
                        }
                        EndDependentFn ()
                    })
                    Method (_SRS, 1, NotSerialized)
                    {
                        CreateWordField (Arg0, 0x02, IOB0)
                        CreateWordField (Arg0, 0x09, IRQM)
                        _DIS ()
                        If (LEqual (IOB0, 0x03BC))
                        {
                            Store (XXXI (One), Local0)
                            If (LGreater (And (Local0, 0xE0), 0x20))
                            {
                                And (Local0, 0xFFFFFF1F, Local0)
                                XXXJ (One, Local0)
                            }
                        }

                        XXXD (One, IOB0)
                        XXXM (One, IRQM)
                        XXXB (One, One)
                    }
                }

                Device (ECP1)
                {
                    Name (_HID, EisaId ("PNP0401"))
                    Method (_STA, 0, NotSerialized)
                    {
                        Store (XXXK (One), Local0)
                        If (Local0)
                        {
                            Store (XXXI (One), Local1)
                            If (Not (And (Local1, 0x80)))
                            {
                                Return (Zero)
                            }
                        }

                        Return (Local0)
                    }

                    Method (_DIS, 0, NotSerialized)
                    {
                        XXXB (One, Zero)
                    }

                    Name (CRPP, ResourceTemplate ()
                    {
                        IO (Decode16, 0x0378, 0x0378, 0x00, 0x08)
                        IO (Decode16, 0x0778, 0x0778, 0x00, 0x08)
                        IRQNoFlags () {7}
                        DMA (Compatibility, NotBusMaster, Transfer8) {1}
                    })
                    Method (_CRS, 0, NotSerialized)
                    {
                        CreateWordField (CRPP, 0x02, IO1)
                        CreateWordField (CRPP, 0x04, IO2)
                        CreateWordField (CRPP, 0x0A, IO3)
                        CreateWordField (CRPP, 0x0C, IO4)
                        CreateWordField (CRPP, 0x11, IRQM)
                        CreateWordField (CRPP, 0x14, DMAM)
                        Store (XXXA (One), Local0)
                        If (And (Local0, One))
                        {
                            Store (XXXC (One), Local0)
                            Store (Local0, IO1)
                            Store (Local0, IO2)
                            Add (Local0, 0x0400, Local0)
                            Store (Local0, IO3)
                            Store (Local0, IO4)
                            Store (XXXL (One), Local0)
                            Store (Local0, IRQM)
                            Store (XXXN (One), Local0)
                            Store (Local0, DMAM)
                        }
                        Else
                        {
                            Store (Zero, IO1)
                            Store (Zero, IO2)
                            Store (Zero, IO3)
                            Store (Zero, IO4)
                            Store (Zero, IRQM)
                            Store (Zero, DMAM)
                        }

                        Return (CRPP)
                    }

                    Name (_PRS, ResourceTemplate ()
                    {
                        StartDependentFnNoPri ()
                        {
                            IO (Decode16, 0x0378, 0x0378, 0x00, 0x08)
                            IO (Decode16, 0x0778, 0x0778, 0x00, 0x08)
                            IRQNoFlags () {7}
                            DMA (Compatibility, NotBusMaster, Transfer8) {1}
                            IO (Decode16, 0x0378, 0x0378, 0x00, 0x08)
                            IO (Decode16, 0x0778, 0x0378, 0x00, 0x08)
                            IRQNoFlags () {7}
                            DMA (Compatibility, NotBusMaster, Transfer8) {3}
                            IO (Decode16, 0x0378, 0x0378, 0x00, 0x08)
                            IO (Decode16, 0x0778, 0x0378, 0x00, 0x08)
                            IRQNoFlags () {5}
                            DMA (Compatibility, NotBusMaster, Transfer8) {1}
                            IO (Decode16, 0x0378, 0x0378, 0x00, 0x08)
                            IO (Decode16, 0x0778, 0x0378, 0x00, 0x08)
                            IRQNoFlags () {5}
                            DMA (Compatibility, NotBusMaster, Transfer8) {3}
                            IO (Decode16, 0x0278, 0x0278, 0x00, 0x08)
                            IO (Decode16, 0x0678, 0x0678, 0x00, 0x08)
                            IRQNoFlags () {7}
                            DMA (Compatibility, NotBusMaster, Transfer8) {1}
                            IO (Decode16, 0x0278, 0x0278, 0x00, 0x08)
                            IO (Decode16, 0x0678, 0x0678, 0x00, 0x08)
                            IRQNoFlags () {7}
                            DMA (Compatibility, NotBusMaster, Transfer8) {3}
                            IO (Decode16, 0x0278, 0x0278, 0x00, 0x08)
                            IO (Decode16, 0x0678, 0x0678, 0x00, 0x08)
                            IRQNoFlags () {5}
                            DMA (Compatibility, NotBusMaster, Transfer8) {1}
                            IO (Decode16, 0x0278, 0x0278, 0x00, 0x08)
                            IO (Decode16, 0x0678, 0x0678, 0x00, 0x08)
                            IRQNoFlags () {5}
                            DMA (Compatibility, NotBusMaster, Transfer8) {3}
                        }
                        EndDependentFn ()
                    })
                    Method (_SRS, 1, NotSerialized)
                    {
                        CreateWordField (Arg0, 0x02, IOB0)
                        CreateWordField (Arg0, 0x11, IRQM)
                        CreateWordField (Arg0, 0x14, DMAM)
                        _DIS ()
                        XXXD (One, IOB0)
                        XXXM (One, IRQM)
                        XXXO (One, DMAM)
                        XXXB (One, One)
                    }
                }
            }

            Device (CRD0)
            {
                Name (_ADR, 0x000C0000)
                OperationRegion (CBR0, PCI_Config, Zero, 0xFF)
                Field (CBR0, DWordAcc, NoLock, Preserve)
                {
                    Offset (0x44), 
                    C044,   32, 
                    Offset (0x80), 
                    C080,   8, 
                    C081,   8, 
                    C082,   8, 
                    C083,   8
                }

                Method (_INI, 0, NotSerialized)
                {
                    Store (Zero, C044)
                }
            }

            Device (CRD1)
            {
                Name (_ADR, 0x000C0001)
            }

            Device (LAN)
            {
                Name (_ADR, 0x000D0000)
                Name (_PRW, Package (0x02)
                {
                    0x1F, 
                    0x05
                })
            }

            Device (PIDE)
            {
                Name (_ADR, 0x000F0002)
                Name (_STR, Unicode ("CS5535 IDE Controller"))
                Method (_STA, 0, NotSerialized)
                {
                    Return (0x0F)
                }

                Device (PRI)
                {
                    Name (_ADR, Zero)
                    Method (_STA, 0, NotSerialized)
                    {
                        Return (0x0F)
                    }

                    Device (MST)
                    {
                        Name (_ADR, Zero)
                        Method (_STA, 0, NotSerialized)
                        {
                            Return (0x0F)
                        }
                    }

                    Device (SLV)
                    {
                        Name (_ADR, One)
                        Method (_STA, 0, NotSerialized)
                        {
                            Return (0x0F)
                        }
                    }
                }
            }

            Device (USB0)
            {
                Name (_ADR, 0x000F0004)
                Name (_STR, Unicode ("CS5535 USB Controller 0"))
                Method (_STA, 0, NotSerialized)
                {
                    Return (0x0F)
                }

                Name (_PRW, Package (0x02)
                {
                    0x05, 
                    0x03
                })
            }

            Device (USB1)
            {
                Name (_ADR, 0x000F0005)
                Name (_STR, Unicode ("CS5535 USB Controller 1"))
                Method (_STA, 0, NotSerialized)
                {
                    Return (0x0F)
                }

                Name (_PRW, Package (0x02)
                {
                    0x06, 
                    0x03
                })
            }
        }
    }
}


------=_Part_1267_4102543.1141696228649--
