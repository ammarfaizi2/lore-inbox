Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265647AbRGFRYH>; Fri, 6 Jul 2001 13:24:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266763AbRGFRX7>; Fri, 6 Jul 2001 13:23:59 -0400
Received: from mailhst2.its.tudelft.nl ([130.161.34.250]:63497 "EHLO
	mailhst2.its.tudelft.nl") by vger.kernel.org with ESMTP
	id <S265647AbRGFRXs>; Fri, 6 Jul 2001 13:23:48 -0400
Date: Fri, 6 Jul 2001 19:22:32 +0200
From: Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [patch] Fix warnings in videobook
Message-ID: <20010706192232.D25204@arthur.ubicom.tudelft.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch fixes the Jade SGML warnings when compiling the videobook:

  jade:videobook.sgml:182:34:E: character data is not allowed here
  jade:videobook.sgml:182:47:E: end tag for "ROW" which is not finished
  jade:videobook.sgml:182:50:E: document type does not allow element "TBODY" here; assuming missing "TGROUP" start-tag
  jade:videobook.sgml:182:50:E: required attribute "COLS" not specified
  jade:videobook.sgml:184:8:E: character data is not allowed here
  jade:videobook.sgml:186:42:E: end tag for element "ENTRY" which is not open
  jade:videobook.sgml:187:6:E: end tag for element "ROW" which is not open

All of which can be fixed by changing <> into <entry>. Patch applies
cleanly against 2.4.6, 2.4.7-pre3, and 2.4.6-ac1. Please apply, it even
makes the tables visible :)


Erik

-- 
J.A.K. (Erik) Mouw, Information and Communication Theory Group, Department
of Electrical Engineering, Faculty of Information Technology and Systems,
Delft University of Technology, PO BOX 5031,  2600 GA Delft, The Netherlands
Phone: +31-15-2783635  Fax: +31-15-2781843  Email: J.A.K.Mouw@its.tudelft.nl
WWW: http://www-ict.its.tudelft.nl/~erik/


Index: Documentation/DocBook/videobook.tmpl
===================================================================
RCS file: /home/erik/cvsroot/elinux/Documentation/DocBook/videobook.tmpl,v
retrieving revision 1.1.1.8
retrieving revision 1.1.1.8.28.1
diff -u -r1.1.1.8 -r1.1.1.8.28.1
--- Documentation/DocBook/videobook.tmpl	2001/02/20 16:52:53	1.1.1.8
+++ Documentation/DocBook/videobook.tmpl	2001/07/06 17:20:09	1.1.1.8.28.1
@@ -179,23 +179,23 @@
    <tgroup cols=3 align=left>
    <tbody>
    <row>
-        <entry>VFL_TYPE_RADIO</><>/dev/radio{n}</><>
+        <entry>VFL_TYPE_RADIO</><entry>/dev/radio{n}</><entry>
 
         Radio devices are assigned in this block. As with all of these
         selections the actual number assignment is done by the video layer
         accordijng to what is free.</entry>
 	</row><row>
-        <entry>VFL_TYPE_GRABBER</><>/dev/video{n}</><>
+        <entry>VFL_TYPE_GRABBER</><entry>/dev/video{n}</><entry>
         Video capture devices and also -- counter-intuitively for the name --
         hardware video playback devices such as MPEG2 cards.</entry>
 	</row><row>
-        <entry>VFL_TYPE_VBI</><>/dev/vbi{n}</><>
+        <entry>VFL_TYPE_VBI</><entry>/dev/vbi{n}</><entry>
         The VBI devices capture the hidden lines on a television picture
         that carry further information like closed caption data, teletext
         (primarily in Europe) and now Intercast and the ATVEC internet
         television encodings.</entry>
 	</row><row>
-        <entry>VFL_TYPE_VTX</><>/dev/vtx[n}</><>
+        <entry>VFL_TYPE_VTX</><entry>/dev/vtx[n}</><entry>
         VTX is 'Videotext' also known as 'Teletext'. This is a system for
         sending numbered, 40x25, mostly textual page images over the hidden
         lines. Unlike the /dev/vbi interfaces, this is for 'smart' decoder 
@@ -302,25 +302,25 @@
    <tgroup cols=2 align=left>
    <tbody>
    <row>
-        <entry>name</><>The device text name. This is intended for the user.</>
+        <entry>name</><entry>The device text name. This is intended for the user.</>
 	</row><row>
-        <entry>channels</><>The number of different channels you can tune on
+        <entry>channels</><entry>The number of different channels you can tune on
                         this card. It could even by zero for a card that has
                         no tuning capability. For our simple FM radio it is 1. 
                         An AM/FM radio would report 2.</entry>
 	</row><row>
-        <entry>audios</><>The number of audio inputs on this device. For our
+        <entry>audios</><entry>The number of audio inputs on this device. For our
                         radio there is only one audio input.</entry>
 	</row><row>
-        <entry>minwidth,minheight</><>The smallest size the card is capable of capturing
+        <entry>minwidth,minheight</><entry>The smallest size the card is capable of capturing
 		        images in. We set these to zero. Radios do not
                         capture pictures</entry>
 	</row><row>
-        <entry>maxwidth,maxheight</><>The largest image size the card is capable of
+        <entry>maxwidth,maxheight</><entry>The largest image size the card is capable of
                                       capturing. For our radio we report 0.
 				</entry>
 	</row><row>
-        <entry>type</><>This reports the capabilities of the device, and
+        <entry>type</><entry>This reports the capabilities of the device, and
                         matches the field we filled in in the struct
                         video_device when registering.</entry>
     </row>
@@ -415,7 +415,7 @@
 	</row><row>
         <entry>VIDEO_TUNER_SECAM</><entry>A SECAM (French) TV tuner</entry>
 	</row><row>
-        <entry>VIDEO_TUNER_LOW</><>
+        <entry>VIDEO_TUNER_LOW</><entry>
              The tuner frequency is scaled in 1/16th of a KHz
              steps. If not it is in 1/16th of a MHz steps
 	</entry>
@@ -432,13 +432,13 @@
    <tgroup cols=2 align=left>
    <tbody>
    <row>
-                <entry>VIDEO_MODE_PAL</><>PAL Format</entry>
+                <entry>VIDEO_MODE_PAL</><entry>PAL Format</entry>
    </row><row>
-                <entry>VIDEO_MODE_NTSC</><>NTSC Format (USA)</entry>
+                <entry>VIDEO_MODE_NTSC</><entry>NTSC Format (USA)</entry>
    </row><row>
-                <entry>VIDEO_MODE_SECAM</><>French Format</entry>
+                <entry>VIDEO_MODE_SECAM</><entry>French Format</entry>
    </row><row>
-                <entry>VIDEO_MODE_AUTO</><>A device that does not need to do
+                <entry>VIDEO_MODE_AUTO</><entry>A device that does not need to do
                                         TV format switching</entry>
    </row>
     </tbody>
@@ -583,30 +583,30 @@
    <tgroup cols=2 align=left>
    <tbody>
    <row>
-   <entry>audio</><>The input the user wishes to query</>
+   <entry>audio</><entry>The input the user wishes to query</>
    </row><row>
-   <entry>volume</><>The volume setting on a scale of 0-65535</>
+   <entry>volume</><entry>The volume setting on a scale of 0-65535</>
    </row><row>
-   <entry>base</><>The base level on a scale of 0-65535</>
+   <entry>base</><entry>The base level on a scale of 0-65535</>
    </row><row>
-   <entry>treble</><>The treble level on a scale of 0-65535</>
+   <entry>treble</><entry>The treble level on a scale of 0-65535</>
    </row><row>
-   <entry>flags</><>The features this audio device supports
+   <entry>flags</><entry>The features this audio device supports
    </entry>
    </row><row>
-   <entry>name</><>A text name to display to the user. We picked 
+   <entry>name</><entry>A text name to display to the user. We picked 
                         "Radio" as it explains things quite nicely.</>
    </row><row>
-   <entry>mode</><>The current reception mode for the audio
+   <entry>mode</><entry>The current reception mode for the audio
 
                 We report MONO because our card is too stupid to know if it is in
                 mono or stereo. 
    </entry>
    </row><row>
-   <entry>balance</><>The stereo balance on a scale of 0-65535, 32768 is
+   <entry>balance</><entry>The stereo balance on a scale of 0-65535, 32768 is
                         middle.</>
    </row><row>
-   <entry>step</><>The step by which the volume control jumps. This is
+   <entry>step</><entry>The step by which the volume control jumps. This is
                         used to help make it easy for applications to set 
                         slider behaviour.</>   
    </row>
@@ -618,15 +618,15 @@
    <tgroup cols=2 align=left>
    <tbody>
    <row>
-                <entry>VIDEO_AUDIO_MUTE</><>The audio is currently muted. We
+                <entry>VIDEO_AUDIO_MUTE</><entry>The audio is currently muted. We
                                         could fake this in our driver but we
                                         choose not to bother.</entry>
    </row><row>
-                <entry>VIDEO_AUDIO_MUTABLE</><>The input has a mute option</entry>
+                <entry>VIDEO_AUDIO_MUTABLE</><entry>The input has a mute option</entry>
    </row><row>
-                <entry>VIDEO_AUDIO_TREBLE</><>The  input has a treble control</entry>
+                <entry>VIDEO_AUDIO_TREBLE</><entry>The  input has a treble control</entry>
    </row><row>
-                <entry>VIDEO_AUDIO_BASS</><>The input has a base control</entry>
+                <entry>VIDEO_AUDIO_BASS</><entry>The input has a base control</entry>
    </row>
    </tbody>
    </tgroup>
@@ -636,13 +636,13 @@
    <tgroup cols=2 align=left>
    <tbody>
    <row>
-                <entry>VIDEO_SOUND_MONO</><>Mono sound</entry>
+                <entry>VIDEO_SOUND_MONO</><entry>Mono sound</entry>
    </row><row>
-                <entry>VIDEO_SOUND_STEREO</><>Stereo sound</entry>
+                <entry>VIDEO_SOUND_STEREO</><entry>Stereo sound</entry>
    </row><row>
-                <entry>VIDEO_SOUND_LANG1</><>Alternative language 1 (TV specific)</entry>
+                <entry>VIDEO_SOUND_LANG1</><entry>Alternative language 1 (TV specific)</entry>
    </row><row>
-                <entry>VIDEO_SOUND_LANG2</><>Alternative language 2 (TV specific)</entry>
+                <entry>VIDEO_SOUND_LANG2</><entry>Alternative language 2 (TV specific)</entry>
    </row>
    </tbody>
    </tgroup>
@@ -867,33 +867,33 @@
    <tgroup cols=2 align=left>
    <tbody>
    <row>
-<entry>VID_TYPE_CAPTURE</><>We support image capture</>
+<entry>VID_TYPE_CAPTURE</><entry>We support image capture</>
 </row><row>
-<entry>VID_TYPE_TELETEXT</><>A teletext capture device (vbi{n])</>
+<entry>VID_TYPE_TELETEXT</><entry>A teletext capture device (vbi{n])</>
 </row><row>
-<entry>VID_TYPE_OVERLAY</><>The image can be directly overlaid onto the
+<entry>VID_TYPE_OVERLAY</><entry>The image can be directly overlaid onto the
                                 frame buffer</>
 </row><row>
-<entry>VID_TYPE_CHROMAKEY</><>Chromakey can be used to select which parts
+<entry>VID_TYPE_CHROMAKEY</><entry>Chromakey can be used to select which parts
                                 of the image to display</>
 </row><row>
-<entry>VID_TYPE_CLIPPING</><>It is possible to give the board a list of
+<entry>VID_TYPE_CLIPPING</><entry>It is possible to give the board a list of
                                 rectangles to draw around. </>
 </row><row>
-<entry>VID_TYPE_FRAMERAM</><>The video capture goes into the video memory
+<entry>VID_TYPE_FRAMERAM</><entry>The video capture goes into the video memory
                                 and actually changes it. Applications need
                                 to know this so they can clean up after the
                                 card</>
 </row><row>
-<entry>VID_TYPE_SCALES</><>The image can be scaled to various sizes,
+<entry>VID_TYPE_SCALES</><entry>The image can be scaled to various sizes,
                                 rather than being a single fixed size.</>
 </row><row>
-<entry>VID_TYPE_MONOCHROME</><>The capture will be monochrome. This isn't a 
+<entry>VID_TYPE_MONOCHROME</><entry>The capture will be monochrome. This isn't a 
                                 complete answer to the question since a mono
                                 camera on a colour capture card will still
                                 produce mono output.</>
 </row><row>
-<entry>VID_TYPE_SUBCAPTURE</><>The card allows only part of its field of
+<entry>VID_TYPE_SUBCAPTURE</><entry>The card allows only part of its field of
                                 view to be captured. This enables
                                 applications to avoid copying all of a large
                                 image into memory when only some section is
@@ -1209,18 +1209,18 @@
    <tbody>
    <row>
 
-   <entry>channel</><>The channel number we are selecting</entry>
+   <entry>channel</><entry>The channel number we are selecting</entry>
    </row><row>
-   <entry>name</><>The name for this channel. This is intended
+   <entry>name</><entry>The name for this channel. This is intended
                    to describe the port to the user.
                    Appropriate names are therefore things like
                    "Camera" "SCART input"</entry>
    </row><row>
-   <entry>flags</><>Channel properties</entry>
+   <entry>flags</><entry>Channel properties</entry>
    </row><row>
-   <entry>type</><>Input type</entry>
+   <entry>type</><entry>Input type</entry>
    </row><row>
-   <entry>norm</><>The current television encoding being used
+   <entry>norm</><entry>The current television encoding being used
                    if relevant for this channel.
     </entry>
     </row>
@@ -1231,9 +1231,9 @@
     <tgroup cols=2 align=left>
     <tbody>
     <row>
-        <entry>VIDEO_VC_TUNER</><>Channel has a tuner.</entry>
+        <entry>VIDEO_VC_TUNER</><entry>Channel has a tuner.</entry>
    </row><row>
-        <entry>VIDEO_VC_AUDIO</><>Channel has audio.</entry>
+        <entry>VIDEO_VC_AUDIO</><entry>Channel has audio.</entry>
     </row>
     </tbody>
     </tgroup>
@@ -1242,11 +1242,11 @@
     <tgroup cols=2 align=left>
     <tbody>
     <row>
-        <entry>VIDEO_TYPE_TV</><>Television input.</entry>
+        <entry>VIDEO_TYPE_TV</><entry>Television input.</entry>
    </row><row>
-        <entry>VIDEO_TYPE_CAMERA</><>Fixed camera input.</entry>
+        <entry>VIDEO_TYPE_CAMERA</><entry>Fixed camera input.</entry>
    </row><row>
-	<entry>0</><>Type is unknown.</entry>
+	<entry>0</><entry>Type is unknown.</entry>
     </row>
     </tbody>
     </tgroup>
@@ -1255,13 +1255,13 @@
     <tgroup cols=2 align=left>
     <tbody>
     <row>
-        <entry>VIDEO_MODE_PAL</><>PAL encoded Television</entry>
+        <entry>VIDEO_MODE_PAL</><entry>PAL encoded Television</entry>
    </row><row>
-        <entry>VIDEO_MODE_NTSC</><>NTSC (US) encoded Television</entry>
+        <entry>VIDEO_MODE_NTSC</><entry>NTSC (US) encoded Television</entry>
    </row><row>
-        <entry>VIDEO_MODE_SECAM</><>SECAM (French) Television </entry>
+        <entry>VIDEO_MODE_SECAM</><entry>SECAM (French) Television </entry>
    </row><row>
-        <entry>VIDEO_MODE_AUTO</><>Automatic switching, or format does not
+        <entry>VIDEO_MODE_AUTO</><entry>Automatic switching, or format does not
                                 matter</entry>
     </row>
     </tbody>
@@ -1341,13 +1341,13 @@
    <tgroup cols=2 align=left>
    <tbody>
    <row>
-   <entry>GREY</><>Linear greyscale. This is for simple cameras and the
+   <entry>GREY</><entry>Linear greyscale. This is for simple cameras and the
                         like</>
    </row><row>
-   <entry>RGB565</><>The top 5 bits hold 32 red levels, the next six bits 
+   <entry>RGB565</><entry>The top 5 bits hold 32 red levels, the next six bits 
                         hold green and the low 5 bits hold blue. </>
    </row><row>
-   <entry>RGB555</><>The top bit is clear. The red green and blue levels
+   <entry>RGB555</><entry>The top bit is clear. The red green and blue levels
                         each occupy five bits.</>
     </row>
     </tbody>
@@ -1479,32 +1479,32 @@
    <tgroup cols=2 align=left>
    <tbody>
    <row>
-        <entry>width</><>The width in pixels of the desired image. The card
+        <entry>width</><entry>The width in pixels of the desired image. The card
                         may use a smaller size if this size is not available</>
 	</row><row>
-        <entry>height</><>The height of the image. The card may use a smaller
+        <entry>height</><entry>The height of the image. The card may use a smaller
                         size if this size is not available.</>
 	</row><row>
-        <entry>x</><>   The X position of the top left of the window. This
+        <entry>x</><entry>   The X position of the top left of the window. This
                         is in pixels relative to the left hand edge of the
                         picture. Not all cards can display images aligned on
                         any pixel boundary. If the position is unsuitable
                         the card adjusts the image right and reduces the
                         width.</>
 	</row><row>
-        <entry>y</><>   The Y position of the top left of the window. This
+        <entry>y</><entry>   The Y position of the top left of the window. This
                         is counted in pixels relative to the top edge of the
                         picture. As with the width if the card cannot
                         display  starting on this line it will adjust the
                         values.</>
 	</row><row>
-        <entry>chromakey</><>The colour (expressed in RGB32 format) for the
+        <entry>chromakey</><entry>The colour (expressed in RGB32 format) for the
                         chromakey colour if chroma keying is being used. </>
 	</row><row>
-        <entry>clips</><>An array of rectangles that must not be drawn
+        <entry>clips</><entry>An array of rectangles that must not be drawn
 			over.</>
 	</row><row>
-        <entry>clipcount</><>The number of clips in this array.</>
+        <entry>clipcount</><entry>The number of clips in this array.</>
     </row>
     </tbody>
     </tgroup>
@@ -1516,11 +1516,11 @@
    <tgroup cols=2 align=left>
    <tbody>
    <row>
-        <entry>x, y</><>Co-ordinates relative to the display</>
+        <entry>x, y</><entry>Co-ordinates relative to the display</>
 	</row><row>
-        <entry>width, height</><>Width and height in pixels</>
+        <entry>width, height</><entry>Width and height in pixels</>
 	</row><row>
-        <entry>next</><>A spare field for the application to use</>
+        <entry>next</><entry>A spare field for the application to use</>
     </row>
     </tbody>
     </tgroup>
